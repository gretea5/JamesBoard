import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jamesboard/constants/AppString.dart';
import 'package:jamesboard/constants/FontString.dart';
import 'package:jamesboard/constants/IconPath.dart';
import 'package:jamesboard/feature/user/screen/MyPageUserEditScreen.dart';
import 'package:jamesboard/feature/user/widget/item/ItemUserGenrePercentInfo.dart';
import 'package:jamesboard/theme/Colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../datasource/model/response/MyPage/MyPageGameStatsResponse.dart';
import '../../../widget/image/ImageCommonMyPageGameCard.dart';
import '../../../widget/item/ItemCommonGameRank.dart';
import '../viewmodel/MyPageViewModel.dart';
import '../widget/chart/ChartUserGenrePercent.dart';
import 'MyPagePlayTimeScreen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final viewModel = context.read<MyPageViewModel>();
      await viewModel.loadUserId();
      await viewModel.getAllPlayedGames();
      await viewModel.getTopPlayedGame();
    });
    _tabController = TabController(length: 2, vsync: this); // 두 개의 탭 설정
  }

  @override
  void dispose() {
    _tabController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MyPageViewModel>(context);

    return Scaffold(
      backgroundColor: mainBlack,
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              CircleAvatar(
                radius: 35,
                backgroundImage: viewModel.userInfo?.userProfile != null
                    ? NetworkImage(viewModel.userInfo!.userProfile!)
                    : AssetImage(IconPath.defaultImage) as ImageProvider,
                backgroundColor: mainBlack,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.userInfo?.userNickname ?? "",
                    style: TextStyle(
                      color: mainWhite,
                      fontSize: 20,
                      fontFamily: FontString.pretendardBold,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPageUserEditScreen(
                            title: AppString.myPageUserEditTitle,
                            userName: viewModel.userInfo?.userNickname ?? "",
                            userImg: viewModel.userInfo!.userProfile,
                          ),
                        ),
                      ).then((result) {
                        if (result == true) {
                          viewModel.loadUserId();
                        }
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: secondaryBlack,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          IconPath.pen,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
          TabBar(
            controller: _tabController,
            labelColor: mainGold,
            // 선택된 탭 텍스트 색
            unselectedLabelColor: mainGrey,
            // 선택되지 않은 탭 텍스트 색
            indicatorColor: mainGold,
            // 인디케이터 색
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
              // 선택된 탭 텍스트 스타일
              fontSize: 16,
              color: mainGold,
              fontFamily: FontString.pretendardBold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              color: mainGrey,
              fontFamily: 'Pretendard',
            ),
            tabs: [
              Tab(text: AppString.missionReport),
              Tab(text: AppString.missionStatistics),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContentMissionReport(),
                _buildTabContentMissionStatistics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 임무 보고
  Widget _buildTabContentMissionReport() {
    final viewModel = Provider.of<MyPageViewModel>(context);
    final isLoading = viewModel.isLoadingMissionRecord;

    return SingleChildScrollView(
      child: ImageCommonMyPageGameCard(
        images: viewModel.playedGames ?? [],
        isLoading: isLoading,
      ),
    );
  }

  // 임무 통계
  Widget _buildTabContentMissionStatistics() {
    final viewModel = Provider.of<MyPageViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppString.missionCategoryStatistics,
                  style: TextStyle(
                    fontSize: 24,
                    color: mainWhite,
                    fontFamily: FontString.pretendardBold,
                  ),
                ),
              ],
            ),
            ChartUserGenrePercent(
              chartData: viewModel.gameStats ??
                  MyPageGameStatsResponse(
                    totalPlayed: 0,
                    genreStats: [],
                    topPlayedGames: [],
                  ),
            ),
            ItemUserGenrePercentInfo(
                genres: viewModel.gameStats?.genreStats ?? []),
            SizedBox(
              height: 32,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.missionTop5CumulativePlays,
                  style: TextStyle(
                    fontSize: 24,
                    color: mainWhite,
                    fontFamily: FontString.pretendardBold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPagePlayTimeScreen(
                          title: AppString.totalMissionCumulativePlays,
                          gameData: viewModel.gameStats?.topPlayedGames ?? [],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppString.seeMore,
                    style: TextStyle(
                      fontSize: 16,
                      color: mainGrey,
                      fontFamily: 'PretendardBold',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            ItemCommonGameRank(
                gameData:
                    viewModel.gameStats?.topPlayedGames.take(5).toList() ?? []),
          ],
        ),
      ),
    );
  }
}
