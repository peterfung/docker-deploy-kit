#!/bin/bash
if [ -n "$(echo $1| sed -n "/^[1-9][0-9]\{0,1\}$/p")" ];then   
    NUM=$1
    let NUM++
    #取得第NUM次部署的HEAD
    COMMIT=$(sed -n "/[a-fA-F0-9]\{7\} dp/p" deploy.log | sed -n "${NUM}p" | awk '{print $3}')
    if [ ! -n "$COMMIT" ]; then
        echo "Deployment not exist."
        exit
    fi
    echo "Rolling back to $COMMIT ..."
    #记录到部署日志
    DATE=$(date "+%Y-%m-%d %H:%M:%S")
    test -s deploy.log && sed -i "1i$DATE $COMMIT rb" deploy.log || echo "$DATE $COMMIT rb" >> deploy.log
    #切换代码版本
    git reset --hard $COMMIT
    #停掉app
    docker-compose -f ../dockerfiles/docker-compose.yml stop flaskapp
    #启动app
    docker-compose \
        -f ../dockerfiles/docker-compose.yml \
        -f ../dockerfiles/docker-compose.pro.yml \
        up --no-deps --build -d flaskapp
    echo "Done."
    exit
else   
    echo -e "Usage:\n\
    回滚到最近第n个历史版本( 1 < n < 99 ):\n\
    ./rollback.sh n"
    exit
fi