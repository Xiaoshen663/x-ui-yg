本项目基于上游X-UI项目进行略微的功能改动！后续将紧跟上游X-UI版本更新！在此感谢[vaxilu](https://github.com/vaxilu/x-ui)、[FranzKafkaYu](https://github.com/FranzKafkaYu/x-ui)及各位为此项目做出贡献

----------------------------------------------------------------------------------------------------------------------------------------------

更新日志：

2022.5.17 更新内容：同步上游源码，优化双栈VPS安装结束后，双IP（V4+V6）登录信息的显示

2022.5.12 更新内容：加入已安装提示，更新脚本时不必重新输入账户、密码、端口（需重装脚本）

2022.4.26 更新上游内容：FranzKafkaYu的TG通知功能

2022.4.16 更新内容：首次安装或者后续设置端口时，如端口被占用会自动提示并要求重新设置端口（直到不冲突为止），防止端口冲突引起的安装失败问题

2022.4.14 更新上游内容：加入IBM Linuxone vps的s390x架构支持（存在被封的可能性）

-------------------------------------------------------------------------------------------------------------------------------------------------

本脚本显示功能更加人性化！已解决各种安装失败问题，并会长期更新，欢迎大家提建议！！

开始安装：

![3a048bcc003d2436e358b0854754825](https://user-images.githubusercontent.com/90416692/165665214-5ce35ed6-843c-4a3b-ba28-817eb87077ec.png)

安装结束：

![8f505c7ff3ee4e5719631daf43e4936](https://user-images.githubusercontent.com/90416692/168718411-cc0fcd52-2a14-4e7b-a68b-0990e420659e.png)

相关信息直接显示：

![542adf59cfd341599f4cc915786e85c](https://user-images.githubusercontent.com/90416692/165665230-ebb36ccd-1531-453a-ab0c-ad1954946711.png)

---------------------------------------------------------------------------------------------------------------------------------------------

### 纯IPV4/纯IPV6的VPS直接运行一键脚本

```
wget -N https://raw.githubusercontents.com/Xiaoshen663/x-ui-yg/main/install.sh && bash install.sh
```

--------------------------------------------------------------------------------------------------------------------------------------------------
### 关于TG通知（上游内容）

使用说明:在面板后台设置机器人相关参数

Tg机器人Token

Tg机器人ChatId

#### Tg机器人周期运行时间，采用crontab语法参考语法：

30 * * * * * //每一分的第30s进行通知

@hourly //每小时通知

@daily //每天通知（凌晨零点整）

@every 8h //每8小时通知

#### TG通知内容：

节点流量使用

面板登录提醒

节点到期提醒

流量预警提醒

#### TG机器人可输入内容：

/delete port将会删除对应端口的节点

/restart 将会重启xray服务，该命令不会重启x-ui面板自身

/status 将会获取当前系统状态

/enable port将会开启对应端口的节点

/disable port将会关闭对应端口的节点

/version v1.5.5将会升级xray到1.5.5版本

/help 获取帮助信息

------------------------------------------------------------------------------------------------------------------------------------------------------

## 相关更新说明请查看[甬哥博客](https://ygkkk.blogspot.com/2022/02/githubx-uitgacmex-uiipv4ipv6v4v6vpsvaxi.html)
![未命名的设计](https://user-images.githubusercontent.com/90416692/163515222-b8c9cb75-7922-40db-87e5-9e15dcbb6892.png)
![甬哥侃侃侃 yyykg](https://user-images.githubusercontent.com/90416692/163515234-b5e40825-bea1-44db-bba4-11223531442c.png)
## 小白独享说明图[全网首发：x-ui面版登录设置解析图，代理节点参数解析图，纯IPV4、纯IPV6登录X-UI面板的多种情况，以及cloudflare小黄云及端口的来龙去脉](https://ygkkk.blogspot.com/2022/03/x-uiipv4ipv6x-uicloudflare.html)

---------------------------------------------------------------------------------------------------------------------------------------------------

### 你可能喜欢

[一键获取最高root权限，自定义root密码](https://github.com/kkkyg/vpsroot)

[Cloudflare WARP 多功能一键脚本](https://github.com/kkkyg/CFwarp)

[acme.sh一键SSL/TLS证书(ecc)申请脚本](https://github.com/kkkyg/acme-script)

[甬哥油管频道：甲骨文云及纯V6相关视频教程](https://www.youtube.com/channel/UCxukdnZiXnTFvjF5B5dvJ5w)

[甬哥博客主页](https://kkkyg.blogspot.com/)

## Stargazers over time

[![Stargazers over time](https://starchart.cc/kkkyg/x-ui-yg.svg)](https://starchart.cc/kkkyg/x-ui-yg)
