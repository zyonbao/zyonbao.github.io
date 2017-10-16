---
layout: post
title: '提交 App Store 出现警告 Missing iOS Distribution signing identity for xxxx'
subtitle: '提交App Store 的时候出现了警告，Missing iOS Distribution signing identity for xxxx，但明明各项证书配置都没什么问题呀。'
date: 2016-02-15
categories: AppStore 提交
cover: '/uploads/791090-20160215130929626-923417572.png'
tags: 提交错误
---

# App Store 提交警告 - Missing iOS Distribution signing identity for xxxx

提交app至appstore的时候出现如下错误：

 ![img](/uploads/791090-20160215130929626-923417572.png)

注：本解决方案仅适用于Keychain中AppleWWDRCA.cer过期问题，表现为Keychain中的各种开发者证书失效，失效原因均为证书的颁发机构失效：

本次的错误经检查为Keychain中AppleWWDRCA.cer过期问题，解决方法如下:

1. 检查Keychain中的开发证书或推送证书出现如下错误：

 ![img](/uploads/791090-20160215130905095-1859611014.png)

2. 确认该证书由AppleWWDRCA引起后，打开Keychain，执行下列操作：


a. 显示已失效的证书(这一步很重要，不然keychain不会显示已经失效的证书)

![img](/uploads/791090-20160215130950611-111676965.png)

b. 删除已过期的证书(检查下在登陆和系统中可能都有)

 ![img](/uploads/791090-20160215131019829-741630516.png)

![img](/uploads/791090-20160215131044126-1047154070.png)

3. 删除掉过期证书后在apple开发者中心重新下载新的AppleWWDRCA.cer并双击安装

<http://developer.apple.com/certificationauthority/AppleWWDRCA.cer>

(默认安装到登陆，之前删除了系统AppleWWDRCA证书，如果机器为多用户开发，也可以将其移动到系统证书中)

4. 重新打包提交