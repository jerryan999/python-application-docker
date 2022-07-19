from flask import Flask, request
from pymongo import MongoClient
import redis
import config
import tasks


app = Flask(__name__)

mongo_client = MongoClient(config.MONGO_HOST, config.MONGO_PORT)
redis_client = redis.Redis(host=config.REDIS_HOST, port=config.REDIS_PORT)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/mongo_health")
def mongo_health():
    db = mongo_client.test
    ok = db.command("ping").get("ok")
    return "<p>MongoDB health check: {}</p>".format(ok)

@app.route("/redis_health")
def redis_health():
    ok = redis_client.ping()
    return "<p>Redis health check: {}</p>".format(ok)   

@app.route('/send_mail', methods=['GET'])
def send_mail():
    email = request.args.get('email')
    tasks.send_mail_async.apply_async(args=[email], countdown=3)
    return "<p>Email sent to {}</p>".format(email)



if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=config.APP_SERVER_PORT)