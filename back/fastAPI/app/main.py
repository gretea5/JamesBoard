from fastapi import FastAPI
from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.triggers.cron import CronTrigger
# from database import get_db
# from models import Content
from recommendation import Recommendation

app = FastAPI()

# APScheduler 스케줄러 초기화
scheduler = BackgroundScheduler()
recommendation = Recommendation()


@app.on_event("startup")
def start_scheduler():
    scheduler.start()


@app.on_event("shutdown")
def shutdown_scheduler():
    scheduler.shutdown()


@app.get("/")
def read_root():
    return {"fast API 작동된다"}

# 자동으로 실행되는 상황임으로 필요 없음
# @app.put("/fastapi/contents")
def run_contents_recommendation():
    recommendation.contents()

# 자동으로 실행되는 상황임으로 필요 없음
# @app.put("/fastapi/hybrid")
def run_hybrid_recommendation():
    recommendation.hybrid()

# 새벽 3시에 실행
scheduler.add_job(run_contents_recommendation, CronTrigger(hour=3, minute=0))
scheduler.add_job(run_hybrid_recommendation, CronTrigger(hour=3, minute=0))