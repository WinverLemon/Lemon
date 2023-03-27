# Nark部署
## Nark短信登录

- [x] 短信登录
- [x] 只支持2.11以下

### 云服务器部署

<CodeGroup>
  <CodeGroupItem title="AMD" active>

```bash
# 新建Nark目录
mkdir /root/Nark 

cd /root/Nark && mkdir -p Config

# 将授权文件放入/root/Nark/Config中
# 将`Config.json`文件放入/root/Nark/Config

# 建立 日志文件夹
cd /root/Nark && mkdir -p logfile 

cd /root/Nark

# 准备拉取启动容器
docker run  -d \
-v  /root/Nark/logfile:/app/logfile \
-v  /root/Nark/Config:/app/Config \
-p 5701:80 \
-e TZ=Asia/Shanghai \
--name Nark \
--privileged=true \
--restart always \
nolanhzy/nark:latest


```

  </CodeGroupItem>
  <CodeGroupItem title="Config.json">
  
```bash
{
  ///浏览器最多几个网页
  "MaxTab": "4",
  //网站标题
  "Title": "Nark",
  //网站公告
  "Announcement": "为提高账户的安全性，请关闭免密支付。",
  ///开启打印等待日志卡短信验证登陆 可开启 拿到日志群里回复 默认不要填写
  "Debug": "",
  ///XDD PLUS Url  http://IP地址:端口/api/login/smslogin
  "XDDurl": "",
  ///xddToken
  "XDDToken": "",
  ///登陆预警 0 0 12 * * ?  每天中午十二点
  "ExpirationCron": "0 0 12 * * ?",
  ///个人资产 0 0 10,20 * * ?  早十点晚上八点
  "BeanCron": "0 0 10,20 * * ?",
  ///=======================================V4配置区域==========================================
  ///v4 post CK  http://ip:端口/updateCookie
  "V4url": "",
  ///=======================================diy配置区域==========================================
  ///diy post CK
  "CallBackUrl": "",
  // ======================================= WxPusher 通知设置区域 ===========================================
  // 此处填你申请的 appToken. 官方文档：https://wxpusher.zjiecode.com/docs
  // WP_APP_TOKEN 可在管理台查看: https://wxpusher.zjiecode.com/admin/main/app/appToken
  // MainWP_UID 填你自己uid
  ///这里的通知只用于用户登陆 删除 是给你的通知
  "WP_APP_TOKEN": "",
  "MainWP_UID": "",
  // ======================================= PUSH 通知设置区域 ===========================================
  ///Push Plus官方网站：http": //www.pushplus.plus  只有青龙模式有用
  ///下方填写您的Token，微信扫码登录后一对一推送或一对多推送下面的token，只填" "PUSH_PLUS_TOKEN",
  "PUSH_PLUS_TOKEN": "",
  //下方填写您的一对多推送的 "群组编码" ，（一对多推送下面->您的群组(如无则新建)->群组编码）
  "PUSH_PLUS_USER": "",
  ///青龙配置  注意对接XDD 对接芝士 设置为"Config":[]
  "Config": [
    {
      // 不要重复的数字
      "QLkey": 1,
      // 服务器昵称
      "QLName": "腾讯云",
      // 青龙访问地址
      "QLurl": "",
      // 青龙的应用ID
      "QL_CLIENTID": "",
      // 青龙的应用SECRET
      "QL_SECRET": "",
      // CK最大容量
      "QL_CAPACITY": 40,
      // WSCK最大容量
      "QL_WSCK": 40,
      // WXPUSHER的应用token，不推送留空
      "WP_APP_TOKEN": ""
    }
  ]
}
```

  </CodeGroupItem>
</CodeGroup>

::: details 点击查看配置目录结构

```
├─ Ark
│  ├─ Config
│  │  └─ Config.json
│  │  └─ Nark.lic
│  └─ logfile
│

```

::: warning
修改了`Config.json`或者更新了容器，都需要重启docker

```bash
docker restart Nark
```