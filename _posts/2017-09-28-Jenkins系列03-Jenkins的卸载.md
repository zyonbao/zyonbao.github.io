---
layout: post
title: 'Jenkins系列03-Jenkins的卸载'
subtitle: '有些时候我们需要重装 Jenkins 或者卸载Jenkins, 这时我们需要怎么做呢?'
date: 2017-09-24
cover: '/upload_imgs/history-imgs/cover-2017-10-14.jpg'
categories: Jenkins
tags: Jenkins 持续集成 CI
---


# Jenkins系列03-Jenkins的卸载

## 卸载 通过Homebrew 安装的 Jenkins

如果你的 jenkins 是通过 homebrew 安装的， 同样也需要使用 homebrew 卸载，卸载非常简单，在 terminal 中执行下面的命令即可：

```shel
brew uninstall jenkins
```

## 卸载安装包直接安装的 Jenkins

从官网下载的 jenkins pkg 的安装包则需要按照以下方法：

* 打开 `Finder`, `Shift+CMD+G` 进入路径：`/Library/Application Support/Jenkins/`  如果该目录下有一个 `Uninstall.command` 的脚本文件， 双击执行，当然也可以在 terminal 中通过命令执行：

```shell
sh "/Library/Application Support/Jenkins/Uninstall.command"
```

这个命令会删除 Jenkins 以及所有的构建。

* 如果**该文件不存在**那就需要手删除了。这时候可以执行命令：

```shell
sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist
sudo rm /Library/LaunchDaemons/org.jenkins-ci.plist
sudo rm -rf /Applications/Jenkins "/Library/Application Support/Jenkins" /Library/Documentation/Jenkins
```

可以删除 Jenkins。但 Jenkins 是卸载掉了， 配置文件用户信息什么的咋办？别担心， 这里还有删除办法:

```shell
#删除所有 jobs 以及 builds
sudo rm -rf /Users/Shared/Jenkins
sudo rm -rf /var/log/jenkins
sudo rm -f /etc/newsyslog.d/jenkins.conf
#删除 jenkins 用户以及用户组(如果你用到了这些)
sudo dscl . -delete /Users/jenkins
sudo dscl . -delete /Groups/jenkins
#下面的命令在新版本的Jenkins的卸载脚本 Uninstall.command 执行过, 所以最好也执行一下
sudo rm -f /etc/newsyslog.d/jenkins.conf
pkgutil --pkgs | grep 'org\.jenkins-ci\.' | xargs -n 1 sudo pkgutil --forget
```

好吧，也许你看出来了，手动删除实际上就是将 `Uninstall.command` 内的命令重新执行了一遍。为什么我要写出来呢？因为怕自己需要手动删除找不到 `Uninstall.command` 啊！

**刚刚发现, 如果安装在当前用户下, 想要卸载干净, 还需要删除 当前用户下的 jenkins 工作目录**

```sh
sudo rm -rf ~/.jenkins
```

