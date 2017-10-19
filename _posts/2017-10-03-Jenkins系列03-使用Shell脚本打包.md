---
layout: post
title: 'Jenkins 的使用 03 - 使用 Shell 脚本打包'
subtitle: '上一节使用了 Jenkins 的插件 Xcode Integration 来集成, 但发现这个方案在升级了 Xcode 9 之后行不太通, 网上的解决方案居然是使用脚本打包, 只能使用 xcodebuild + 脚本了'
date: 2017-10-03
cover: '/upload_imgs/history-imgs/cover-2017-10-14.jpg'
categories: Jenkins
tags: Jenkins 持续集成 CI
---

# Jenkins 的使用 03 - 使用 Shell 脚本打包

升级了 Xcode 9 之后, 使用 Jenkins 的打包一直报错, 提示找不到对应的描述文件。google 搜了一下， 发现可能是 Xcode 9 之后插件拿不到钥匙串里的证书了。 只能使用脚本的方式打包，没办法， 赶紧学习一下啦， 苹果毕竟是开发者的爸爸。。。

主要是 `xcodebuild`的参数问题需要自己配置， 但 `Git` 依旧可以用插件来实现， 当然在命令里加几句也没啥啦， 但这边希望实现自主选择编译分支，所以这里依旧使用了插件来实现`Git`部分的功能。

第一步, 检查一下插件是否安装:
| 插件名称                  | 插件功能       |
| --------------------- | ---------- |
| Git Parameter Plug-In | 可以在编译时选择分支 |
| Git plugin            | 用这个插件来管理分支 |

这里不再需要安装`Xcode Integration`因为这里都是命令执行的。
在新建项目时候， **构建**步骤中不要选择Xcode了，由于新增了自定义Branch选择编译， 因此**General**步骤中`参数化构建过程`需要勾上。
如下图：
![jenkins-shell-04](/upload_imgs/jenkins-shell/jenkins-shell-04.png)
**General**部分需要勾上， 点击`添加参数`添加`Git Parameter`并自定义一个`BRANCH`的参数名,这个名字将会用在下面Git 选择分支的地方。
![jenkins-shell-00](/upload_imgs/jenkins-shell/jenkins-shell-00.png)

![jenkins-shell-01](/upload_imgs/jenkins-shell/jenkins-shell-01.png)

![jenkins-shell-02](/upload_imgs/jenkins-shell/jenkins-shell-02.png)

![jenkins-shell-03](/upload_imgs/jenkins-shell/jenkins-shell-03.png)





