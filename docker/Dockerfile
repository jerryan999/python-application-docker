FROM python:3.9.13-slim as  python-deps

RUN apt-get update -y && apt-get install -y gcc
WORKDIR /usr/app
RUN python -m venv /usr/app/venv
ENV PATH="/usr/app/venv/bin:$PATH"
COPY requirements.txt ./
RUN pip install --upgrade pip==20.1.1 && \
    pip install -r requirements.txt   && \
    rm requirements.txt


FROM python:3.9.13-slim
RUN apt-get update -y && apt-get install -y supervisor
RUN groupadd -g 999 python && \
    useradd -r -u 999 -m -g python ec2-user

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV HOME=/home/ec2-user
ENV APP_HOME=/home/ec2-user/python-app
WORKDIR $APP_HOME

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY . $APP_HOME
COPY --chown=ec2-user:python --from=python-deps /usr/app/venv /usr/app/venv
RUN ln -s /usr/app/venv /home/ec2-user/python-app/venv

RUN chown -R ec2-user:python $APP_HOME
ENV PATH="$APP_HOME/venv/bin:$PATH"

USER 999

ENTRYPOINT ["/home/ec2-user/python-app/start_server.sh"]
