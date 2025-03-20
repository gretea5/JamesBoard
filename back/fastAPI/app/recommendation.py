import pandas as pd
import numpy as np
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
from scipy.sparse import csr_matrix
from scipy.sparse.linalg import svds
from sklearn.cluster import KMeans
import faiss
from sklearn.decomposition import TruncatedSVD
import matplotlib.pyplot as plt
from sklearn.metrics import silhouette_score


import database


# 현재는 코드는 csv 데이터를 기반으로 작성되어있음.
# db에 데이터 삽입 후, db 데이터를 참고 및 수정하는 형식으로 수정 필요

# 로컬 함수
def recommend_games_for_new_user_with_ratings(new_user_ratings, user_name, max_k=20, k_svd=10, top_n=25):
    """
    새 사용자의 평점과 플레이타임을 기반으로 추천 게임 리스트를 반환하는 함수.
    
    Parameters:
        new_user_ratings (dict): 게임명과 평점 및/또는 플레이타임을 포함한 딕셔너리.
        user_name (str): 새 사용자의 이름.
        pivot (DataFrame): 기존 사용자 평점 데이터 (피벗 테이블).
        ratings (DataFrame): 원본 데이터셋 (게임 이름 및 ID).
        max_k (int): KMeans 알고리즘의 최대 클러스터 수.
        k_svd (int): SVD 차원 수.
        top_n (int): 추천할 게임 수.
    
    Returns:
        recommended_games (list): 추천된 게임 이름 목록.
        recommended_game_ids (list): 추천된 게임 ID 목록.
    """
    ratings, pivot = set_pivot()
    
    # 1️⃣ 데이터 클러스터링을 위한 KMeans 군집화 수행
    pivot_without_user = pivot.drop(columns=["cluster"], errors="ignore").fillna(0)
    n_clusters = find_optimal_clusters(pivot_without_user, max_k)
    
    kmeans = KMeans(n_clusters=n_clusters, random_state=42)
    pivot["cluster"] = kmeans.fit_predict(pivot_without_user)

    # 2️⃣ 새 사용자 만족도 계산
    satisfaction_scores = {}
    playtimes = [v["playtime"] for v in new_user_ratings.values() if "playtime" in v]
    P_max = max(playtimes) if playtimes else 1  # 플레이타임이 없을 수도 있으므로 대비

    for game, data in new_user_ratings.items():
        R = data.get("rating", 0)  # 평점이 없으면 0
        P = data.get("playtime", 0)  # 플레이타임이 없으면 0
        P_norm = P / P_max  # 플레이타임 정규화
        
        S = (0.5 * R) + (0.5 * P_norm * 10)  # 종합 만족도 계산
        satisfaction_scores[game] = round(S, 2)

    # 3️⃣ 피벗 테이블에 새 사용자 추가
    pivot = add_or_update_user_ratings(user_name, satisfaction_scores, pivot)

    # 4️⃣ SVD 기반 차원 축소 및 FAISS를 이용한 유사 사용자 검색
    sparse_pivot = csr_matrix(pivot.drop(columns=["cluster"], errors="ignore").fillna(0))  # 클러스터 컬럼 제외
    u, s, vt = svds(sparse_pivot, k=k_svd)
    reduced_matrix = np.dot(u, np.dot(np.diag(s), vt))
    dense_matrix = reduced_matrix.astype("float32")  # FAISS는 float32만 지원
    index = faiss.IndexFlatL2(dense_matrix.shape[1])  # L2 거리 기반 Index
    index.add(dense_matrix)  # 사용자 데이터 추가

    # 5️⃣ 새 사용자의 벡터 변환
    new_user_vector = transform_new_user(user_name, pivot, vt)
    new_user_vector = reshape_vector_for_faiss(new_user_vector, index.d)

    # 6️⃣ 유사 사용자 찾기
    similar_users = get_similar_users_faiss(new_user_vector, index, pivot)

    # 7️⃣ 유사 사용자 기반 추천 게임 리스트 생성
    similar_user_ratings = pivot.loc[similar_users].drop(columns=["cluster"], errors="ignore")
    recommendations = similar_user_ratings.mean(skipna=True).sort_values(ascending=False)
    recommendations = recommendations[~recommendations.index.isin(list(new_user_ratings.keys()))]  # 이미 플레이한 게임 제외
    game_names = recommendations.index.tolist()[:top_n]

    # 8️⃣ 게임 ID 가져오기
    game_id_df = ratings[ratings["name"].isin(game_names)][["name", "ID"]].drop_duplicates()
    game_id_df["name"] = pd.Categorical(game_id_df["name"], categories=game_names, ordered=True)
    game_id_df = game_id_df.sort_values("name")
    game_ids = game_id_df["ID"].tolist()

    return game_names, game_ids


def find_optimal_clusters(data, max_k=10):
    """
    엘보우 기법을 사용하여 최적의 클러스터 수를 찾는 함수
    """
    distortions = []
    for k in range(1, max_k+1):
        kmeans = KMeans(n_clusters=k, random_state=42)
        kmeans.fit(data)
        distortions.append(kmeans.inertia_)

    # 가장 큰 엘보우 지점을 찾는 방법
    optimal_k = np.argmin(np.diff(distortions)) + 2
    return optimal_k


def get_similar_users_faiss(user_vector, index, pivot, top_k_users=10):
    """
    FAISS를 이용해 가장 유사한 기존 사용자 top_k_users를 찾음
    """
    _, indices = index.search(user_vector, top_k_users)
    similar_users = pivot.index[indices[0]].tolist()
    return similar_users


def add_or_update_user_ratings(user, new_ratings, pivot):
    """
    새로운 사용자는 추가하고, 기존 사용자는 평점 데이터를 업데이트하는 함수.
    new_ratings: {게임명: 평점} 형태의 딕셔너리
    """
    if user in pivot.index:
        for game, rating in new_ratings.items():
            if game in pivot.columns:
                pivot.at[user, game] = rating
            else:
                pivot[game] = 0  # 모든 사용자에 대해 기본값 0 추가
                pivot.at[user, game] = rating
        print(f"✅ {user}의 평점이 갱신되었습니다.")
    else:
        new_user_df = pd.DataFrame([new_ratings], index=[user])
        pivot = pd.concat([pivot, new_user_df], axis=0).fillna(0)
        print(f"✅ {user}가 새로 추가되었습니다.")

    return pivot


def transform_new_user(user, pivot, vt):
    """
    새로운 사용자의 벡터를 기존 SVD 행렬을 활용해 변환.
    """
    if user not in pivot.index:
        print(f"{user} 데이터가 없습니다.")
        return None
    
    user_vector = pivot.drop(columns=["cluster"], errors="ignore").loc[user].values.reshape(1, -1)
    
    if user_vector.shape[1] != vt.shape[1]:
        print(f"차원 불일치: user_vector {user_vector.shape}, vt {vt.shape}")
        return None

    reduced_vector = np.dot(user_vector, vt.T)
    
    return reduced_vector.astype("float32")


def reshape_vector_for_faiss(vector, target_dim):
    current_dim = vector.shape[1]
    
    
    if current_dim > target_dim:
        return vector[:, :target_dim]
    elif current_dim < target_dim:
        padding = np.zeros((vector.shape[0], target_dim - current_dim))  # 0-padding 추가
        return np.hstack((vector, padding))
    
    return vector


def set_pivot(file_path = "archive/filtered_reviews_korea_patch.csv"):
    # ratings = pd.read_csv(file_path, sep=",", encoding="utf-8").dropna(subset=["user", "rating", "name"])
    ratings = pd.read_csv(file_path, sep=",", encoding="utf-8").dropna(subset=["user", "rating", "name"])
    ratings["user"] = ratings["user"].str.strip()
    ratings["rating"] = ratings["rating"].round(2)
    ratings["name"] = ratings["name"].str.strip()
    ratings = ratings[ratings["rating"] > 0]

    pivot = ratings.pivot_table(index="user", columns="name", values="rating")

    return ratings, pivot


class Recommendation:
    def contents():
        # 보드게임 데이터 로드
        df = pd.read_csv("boardgames_bert_improved.csv", sep=",", encoding="latin1")

        # 상위 1000개 데이터 사용
        df = df.head(1000)

        # 결측치 처리
        df["Title"] = df["Title"].fillna("")
        df["description_detail"] = df["description_detail"].fillna("")
        df["Description"] = df["Description"].fillna("")
        df["category_bert"] = df["category_bert"].fillna("")

        # SBERT 모델 로드
        model = SentenceTransformer("stsb-roberta-large")

        # 게임 설명 + 카테고리를 사용한 임베딩
        sentences = df["description_detail"].astype(str)
        sentence_embeddings = model.encode(sentences.tolist())

        # 코사인 유사도 계산
        cosine_sim = cosine_similarity(sentence_embeddings, sentence_embeddings)

        # 각 게임별 유사한 게임 100개를 저장할 데이터프레임 생성
        recommendations = []

        for game_idx, game_name in enumerate(df["Game_Id"]):
            sim_scores = list(enumerate(cosine_sim[game_idx]))
            sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)[1:101]  # 본인 제외 100개

            top_100_games = [df["Game_Id"].iloc[i[0]] for i in sim_scores]
            recommendations.append([game_name] + top_100_games)

        # 데이터프레임으로 변환
        columns = ["Game_Id"] + [f"Rank_{i+1}" for i in range(100)]
        recommendations_df = pd.DataFrame(recommendations, columns=columns)

        # CSV 파일로 저장
        recommendations_df.to_csv("boardgame_similarity.csv", index=False, encoding="utf-8-sig")
        print("CSV 파일 저장 완료: boardgame_similarity.csv")
        
        # 소요시간 2분 40초


    def hybrid():
        new_user_ratings = {
            "Brass: Birmingham": {"rating": 8.5},
            "Dune: Imperium": {"playtime": 120},
            "Too Many Bones": {"rating": 9.0, "playtime": 150}
        }

        user_name = "김동현"

        recommended_games, recommended_game_ids = recommend_games_for_new_user_with_ratings(
            new_user_ratings, user_name, max_k=20, k_svd=10, top_n=25
        )

        print(f"추천된 게임: {recommended_games}")
        print(f"추천된 게임 ID: {recommended_game_ids}")

        # 게임 추천해주는데, 소요된 시간 : 1분 42초

