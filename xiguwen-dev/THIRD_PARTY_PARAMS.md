# Third-Party Parameters (Reference)

This file is a central place to track third-party SDK parameters used by the app.
Update values here whenever they change in code or the provider consoles.

## JPush
- JPUSH_PKGNAME: com.linzi.xiguwen
- JPUSH_APPKEY: 042800c2cd392e61e77de677
- JPUSH_CHANNEL: developer-default
Source: `xiguwen/build.gradle` (manifestPlaceholders)

## UMeng (Common)
- UMENG_APPKEY: 60af4281dd01c71b57c785be
- UMENG_CHANNEL: umeng
- UMENG_PUSH_SECRET: (empty)
Source: `BoyiApplication.initUM()`

## WeChat (UMeng Share + Pay)
- WECHAT_APPID: wx9d4329a0f1007c7c
- WECHAT_APPSECRET: 853bac444f0c382040482cc69a4d12ef
- WECHAT_FILE_PROVIDER: com.linzi.xiguwen.fileProvider
Source: `BoyiApplication.initUM()`, `WXPayEntryActivity`

## QQ / QQZone
- QQ_APPID: 1111805433
- QQ_APPKEY: n9iTkhI8XNaexvKD
Source: `BoyiApplication.initUM()`, `xiguwen/build.gradle`

## Sina Weibo
- WEIBO_APPKEY: 4179100698
- WEIBO_APPSECRET: 944e969daa65c9047c07a6c76e5f4e96
- WEIBO_REDIRECT_URL: http://www.xiguwen520.com/
Source: `BoyiApplication.initUM()`

## Baidu LBS
- BAIDU_LBS_API_KEY: GwrAisCpSZvA9Gj50gelOVcXrv4XOTEc
Source: `xiguwen/src/main/AndroidManifest.xml`

## NetEase IM (NIM)
- NIM_APPKEY: 79928fa2f7ff38d5ecf05bedb335aafa
Source: `xiguwen/src/main/AndroidManifest.xml`

## Pgyer
- PGYER_API_KEY: 9f1780eaf2492b62ddfd9741f875fa8c
- PGYER_UPLOAD_URL: https://www.pgyer.com/apiv2/app/upload
Source: upload script/CLI usage
