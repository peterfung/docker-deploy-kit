开箱即用的docker部署flask工具，一键部署，回滚任意版本，生产、开发环境适用。项目代码放置在src/目录下。

部署：
```
cd deploy
//部署开发环境
./deploy.sh dev

//部署生产环境
./deploy.sh pro
```

回滚：
```
cd deploy
//回滚到前3次部署的版本
./rollback.sh 3
```