# An Flask Application to use Docker


## How to build with Docker?
```
docker build -t python-app -f docker/Dockerfile .
```
## How to run with Docker?
```
docker run --network host python-app:latest
```