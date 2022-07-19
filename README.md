# An Flask Application to use Docker
This is an simple python web application to use Docker. Its' purpose is to show how to dockerize a python application which connects to service from host such as mongoDB and Redis. 

## Prerequisites
- Host machine with mongoDB and Redis installed
- Docker
- Python 3.9 or higher

## Web Application
Here, we use the popular Flask framework to create a web application. 
The four routes are:
- /: This is the index route. It will show the welcome message.
- /mongo_health: This is the route to check the health of mongoDB. 
- /redis_health: This is the route to check the health of Redis.
- /send_mail: This is the route to try to use asyncnious worker to send an email.


## How to build with Docker?
```
docker build -t python-app -f docker/Dockerfile .
```
## How to run with Docker?
```
docker run --network host python-app:latest
```