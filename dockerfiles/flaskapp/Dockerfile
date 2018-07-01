FROM python:3.6-alpine3.7
RUN mkdir -p /usr/app/src
WORKDIR /usr/app/src
ADD requirements.txt /usr/app/src/
RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt
