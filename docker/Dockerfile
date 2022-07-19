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
WORKDIR /home/ec2-user

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY --chown=ec2-user:python . ./python-app
COPY --chown=ec2-user:python --from=python-deps /usr/app/venv /usr/app/venv
RUN ln -s /usr/app/venv /home/ec2-user/python-app/venv

USER 999

ENV PATH="/home/ec2-user/python-app/venv/bin:$PATH"

WORKDIR /home/ec2-user/python-app
CMD ["/bin/bash", "start_server.sh"]