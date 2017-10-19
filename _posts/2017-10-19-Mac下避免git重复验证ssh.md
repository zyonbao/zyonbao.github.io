---
layout: post
title: 'Mac下避免使用Git总是提示Enter passphrase for key 的解决方法'
subtitle: '明明已经配置了ssh, Github 也设置了，还是一操作 Git 就提示输入验证，感谢StackOverFlow再一次拯救了我。'
date: 2017-10-19
cover: ''
categories: 其他
tags: git的使用
---


# Mac下避免使用Git总是提示Enter passphrase for key 的解决方法

发现电脑上的每次对github进行操作都会提示：![2017-10-19-git-ssh](/Users/zyon/zyonbao.github.io/upload_imgs/others/2017-10-19-git-ssh.png)

一次两次还好， 每次都输入分分钟抓狂有木有，google了一下， Mac 下可以将 `ssh key`加入钥匙串，以下是原文翻译：
>在 MacOS 上你可以用下面的命令将你的私钥加入到 Keychains：
>
>```shell
>ssh-add -K /path/to/private_key
>```
>如果你的私钥 private key 存储在 `~/.ssh` 目录下且名为 `id_rsa`的话：
>```shell
>ssh-add -K ~/.ssh/id_rsa
>```

试了一下果然不提示了。再次感叹，Google大法好。

其中， `-K`表示加入钥匙串， 如果不加`-K`参数， 可能会在重启后失效。这点要注意哦！