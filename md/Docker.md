# Docker部署
## Pro

```
# 新建Pro目录
mkdir /root/Pro
cd /root/Pro && mkdir -p Config

# 将`Config.json`文件放入/root/Pro/Config
```

```
docker run -d \
 -v /root/Pro:/app/Data \
 -e Prolic=3ae0213038f94cefa1cc0c983435468e  \
 -e User=WinverLemon \
 -e Pwd=15726199557Wang \
 -p 5701:5016 \
 -e TZ=Asia/Shanghai \
 --name Pro \
 --privileged=true \
 --restart always \
nolanhzy/pro 
```

## QRabbit

```
# 新建QRabbit目录
mkdir /root/QRabbit
cd /root/QRabbit && mkdir -p Config
```

```
docker run -d \
 -v /root/QRabbit/Config:/Rabbit/Config \
 -p 5702:1234 \
 -e TZ=Asia/Shanghai \
 --name QRabbit \
 --privileged=true \
 --restart always \
ht944/qrabbit
```

## Bncr

```
# 新建Bncr目录
mkdir /root/Bncr
```

```
docker run -d \
 -v /root/Bncr:/bncr/BncrData \
 -p 9090:9090 \
 -e TZ=Asia/Shanghai \
 --name Bncr \
 --privileged=true \
 --restart always \
 --log-opt max-size=5m \
 --log-opt max-file=3 \
anmour/bncr && docker attach bncr
```
注：进入容器交互控制台 docker attach bncr
