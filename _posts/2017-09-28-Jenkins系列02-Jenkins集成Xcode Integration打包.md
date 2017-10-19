---
layout: post
title: 'Jenkins 的使用 02 - Jenkins 集成 Xcode Integration 打包'
subtitle: '安装好了 Jenkins, 不让它做点什么岂不可惜？这一节我们来记录下在 Xcode 9 下自动打包的步骤。'
date: 2017-09-24
cover: '/upload_imgs/history-imgs/cover-2017-10-14.jpg'
categories: Jenkins
tags: Jenkins 持续集成 CI
---

# Jenkins 的使用 02 - Jenkins 集成 Xcode Integration 打包

目前这里主要的开发任务仍然是 iOS 开发, 因此这里也只涉及到 Jenkins + Xcode 的方式打包.

打开`jenkins`即进入[http://localhost:8080/](http://localhost:8080/)并登陆账户, 就可以看到`新建任务`的按钮. 但在新建任务之前, 注意先检查一下已经安装的插件, 如果不想接触太多 shell 方面的内容, 就需要将这块儿主要交给插件了, 需要用到的插件主要有:

| 插件名称                                     | 插件功能                                  |
| ---------------------------------------- | ------------------------------------- |
| Xcode integration                        | 集成Xcode 免脚本执行编译指令                     |
| GIT plugin                               | 集成 Git, 当然如果是用SVN可以用对应的 SubVersion 插件 |
| Keychains and Provisioning Profiles Management | 配置钥匙串和描述文件                            |

1. 首先我们来配置一下**钥匙串访问**

确认安装后, 先来配置一下 **钥匙串访问**, 点击`Jenkins>系统管理>Keychains and Provisioning Profiles Management`就可以看到:
![jenkins-conifgxcode-00](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-00.png)

其中, 通过

![jenkins-conifgxcode-01](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-01.png)

可以这里上传`login.keychain`和打包可能需要用到的众多`Provisioning Profiles`, 可以让 Jenkins 在多用户条件下能够访问钥匙串和描述文件打包. 具体的文件路径和作用, 可以点击输入框右边的`?`标志, 都已经解释的很明白啦.
> login.keychain 的目录位于 "/Library/keychains/login.keychain"
> 描述文件的目录位于 ~/Library/MobileDevice/Provisioning Profiles (如果编译用户不是当前用户, 得换成绝对路径)

![jenkins-conifgxcode-02](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-02.png)
差不多就是这样.

2. 接着我们来配置一下`ssh密钥`
  同样, 点击`Jenkins>Credentials>Configure Credentials`选择`Global credentials`, 点击`Add Credentials`
  ![jenkins-conifgxcode-03](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-03.png)
  这里我选择的是从启动用户的`~/.ssh`文件夹中直接读取, 如果非当前用户, 则需按需选择(比如选择`Enter Directly`可以直接输入密钥).
  **这一步非常重要, 如果配置不好, 就无法连接Git 服务器了**
3. 配置好以上两步, 就可以着手新项目的配置啦:
  点击`新建`可以看到下面的页面:
  ![jenkins-conifgxcode-04](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-04.png)

这里我们选择`构建一个自由风格的软件项目`, 名字叫"DemoProject" 点击`OK`创建项目, 即可进入项目配置页面**General**:
![jenkins-conifgxcode-05](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-05.png)
按需填写, 接着看**源码管理**:
![jenkins-conifgxcode-06](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-06.png)
这里使用 Git 管理源码, 因此这里填写 Git 的远程仓库地址, 如果**填写完 Repository URL 后提示了很多错误的话, 你就得好好检查前面的 'Credentials' 的配置问题了**

关于**构建触发器**这块儿, 按需选择就可以了, 这里选择的是`Poll SCM`, 填写图中规则后为"每隔五分钟检查远程仓库有没有更新, 有的话就 pull 并执行构建"(关于 Poll SCM 的规则, 点击右边问号可以详细了解):
![jenkins-conifgxcode-07](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-07.png)

**构建环境**按需选择即可, 这里笔者没有执行任何操作, 就不讲了. 重点是**构建**的操作:
![jenkins-conifgxcode-08](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-08.png)
这里用的是 Xcode 构建, 所以选择的是Xcode, 如果还需要执行`cocoapods`的`pod install`操作, 需要增加构建步骤`Execute Shell`并**将新增的"Execute Shell"步骤拖动到"Xcode"**上面, 这样就会先执行`shell`在执行`xcode构建`了, 如图:
![jenkins-conifgxcode-09](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-09.png)
这里的**Execute Shell**中的为pod脚本:
```sh
#!/bin/bash -l
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
pod install --verbose --no-repo-update
```
至于下面的`General Build Settings` 按需选择即可, 在这里可以配置需要编译的 `target` 、`build 前是否 clean`  、`是否允许编译失败(hint里面说这个在单元测试的时候很好用)` 、`是否生成Archive文件``编译环境`。
![jenkins-conifgxcode-10](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-10.png)

这里的 `Development Team ID`需要填写一下, 这是签名打包时候重要的参数之一。可以从苹果官网获取, 传送门:<https://developer.apple.com/account/#/membership>, 当然, 得先登录。哈哈哈。

![jenkins-conifgxcode-11](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-11.png)
![jenkins-conifgxcode-12](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-12.png)

这里`Advanced Xcode build options`主要是对编译时的各种参数配置, 输入输出文件夹什么的, 按照对应的需要填写就好。`workspace`和`project file`根据对应填写, 在使用`workspace`管理项目的时候可以填写该项， 比如使用`cocoapods`的时候。

到这里就可以进入项目主页, 点击`立即构建`进行构建项目啦!
![jenkins-conifgxcode-13](/upload_imgs/jenkins-config-xcode/jenkins-conifgxcode-13.png)


