#!/bin/bash
if [ "$1" == "pro" ]; then
    echo -e "Deploying production app..."
    DATE=$(date "+%Y-%m-%d %H:%M:%S")
    #获取当前代码HEAD前6位，默认值null
    COMMIT=$(git rev-parse HEAD)
    COMMIT=${COMMIT:0:7}
    COMMIT=${COMMIT:-null};
    #记录到部署日志
    test -s deploy.log && sed -i "1i$DATE $COMMIT dp" deploy.log || echo "$DATE $COMMIT dp" >> deploy.log
    #更新代码
    git pull origin master
    git reset --hard origin/master
    #停掉app
    docker-compose -f ../dockerfiles/docker-compose.yml stop flaskapp
    #启动app
    docker-compose \
        -f ../dockerfiles/docker-compose.yml \
        -f ../dockerfiles/docker-compose.pro.yml \
        up --no-deps --build -d flaskapp
    echo "Done."
    exit
elif [ "$1" == "dev" ]; then
    echo -e "Deploying development app..."
    DATE=$(date "+%Y-%m-%d %H:%M:%S")
    #获取当前代码HEAD前6位，默认值null
    COMMIT=$(git rev-parse HEAD)
    COMMIT=${COMMIT:0:7}
    COMMIT=${COMMIT:-null};
    #记录到部署日志
    test -s deploy.log && sed -i "1i$DATE $COMMIT dp" deploy.log || echo "$DATE $COMMIT dp" >> deploy.log
    #停掉app
    docker-compose -f ../dockerfiles/docker-compose.yml stop flaskapp
    #启动app
    docker-compose \
        -f ../dockerfiles/docker-compose.yml \
        up --no-deps --build flaskapp
    echo "Done."
    exit
else
    echo -e "Usage:\n\
    Deploy development app:\n\
    ./deploy.sh dev\n\n\
    Deploy production app:\n\
    ./deploy.sh pro"
    exit
fi
