### Docker 的使用

#### 认证方式

目前支持 AD 域认证，增补了MAIL SMTP协议认证。

#### 变量

##### 认证方式

认证方式目前的可选值为： AD, MAIL (注意均需大写)

1. **AUTH_DEFAULT**      首选认证方式，必设
1. **AUTH_FALLBACK**     首选方式认证失败后的替补认证方式，可以不设，默认：没有

##### AD域认证参数

1. **EXPIRES_SECONDS**  Token 有效时间，以“秒”为单位
2. **AD_DOMAIN**  AD的域名，如 "gugud.com"
3. **AD_SERVER**  AD服务器地址，如 "127.0.0.1"
4. **AD_PORT**  AD服务器端口，默认 389
5. **AD_BASE**  AD认证的BASE，如 "dc=people,dc=gugud,dc=com"
6. **AD_USER**  AD认证的查询用户账号，如 "someone"
7. **AD_PASSWD** AD认证的查询用户口令，如 "secret"

##### MAIL认证参数

1. **MAIL_HOST** 邮件主机
1. **MAIL_DOMAIN** 邮件发送域
1. **MAIL_PORT** SMTP端口，默认 25
1. **MAIL_AUTHTYPE**  邮件口令加密方式，允许值：plain, login, cram_md5


运行：

```
docker run -d -p 3000:3000 -e AD_SERVER=cloud.gugud.com -e ... index.alauda.cn/gugud/T181
```

-e 后面的 ... 请自行按需要将变量值补齐
