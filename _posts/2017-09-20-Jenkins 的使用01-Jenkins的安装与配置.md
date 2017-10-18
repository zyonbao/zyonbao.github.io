---
layout: post
title: 'Jenkins 的使用 01 - Jenkins 的安装与配置'
subtitle: '一直想学一下 Jenkins 这个神器，这个据说堪称持续集成自动打包的神器。好在网上大牛们的坑已经提前帮我踩过了， 这里记录下安装与使用的过程好啦。'
date: 2017-09-14
cover: '/upload_imgs/history-imgs/cover-2017-10-14.jpg'
categories: Jenkins
tags: Jenkins 持续集成 CI
---

# Jenkins 的使用 01 - Jenkins 的安装与配置

**大前提**
jenkins 基于 java, 因此没有安装配置好 java 运行环境的童鞋, 请自行搜索引擎, 写的好的非常多,这里不再赘述.

## 一. Jenkins 的安装

### 通过 Homebrew 安装
```sh
brew install jenkins
```
没错, 就这么简单. 强烈使用 brew 安装 jenkins, 启动项, 环境什么的全都给配置好了, 一键式的解决方案. 由于笔者这里的 brew 网络环境比较差, 下载了好几次没下载下来, 十分惋惜. 但还是十分推荐使用 homebrew 安装.

当然 homebrew 的安装与升级这里也就不说了. 网上教程很多, 也很简单. 请大家自行搜索.

### 通过安装包直接安装

1. 安装 Jenkins 到 Mac

由于本地网络的问题，使用`brew`安装网络经常卡顿, 这里实际上操作采用的是[官网](https://jenkins.io/)提供的`.pkg`安装包的形式安装.这里记录一下主要安装方式:

其实也就是 Mac 上常见的 `pkg`安装方式,傻瓜式一路点击. 但有些还是需要注意一下的!

![Jenkins 安装包](/upload_imgs/jenkins-install/jenkins-install-00.png)

![开始安装 Jenkins](/upload_imgs/jenkins-install/jenkins-install-01.png)

![这里需要点击自定义设置用户](/upload_imgs/jenkins-install/jenkins-install-02.png)

![Jenkins 安装完成](/upload_imgs/jenkins-install/jenkins-install-03.png)

**为了避免权限问题, 请注意在安装类型步骤, 选择自定义去掉 `start boot as "jenkins"`项**

不然在后面配置 git ssh 和 Xcode 的证书问题时, 需要把当前用户的证书和ssh文件全都复制到"jenkins"用户下. 这个问题有需要咱们再后续更新中慢慢探讨.时间紧迫. 接着下一步.
2. 启动 jenkins
  由于我们使用了Jenkins的`pkg`安装包且并没有选择让jenkins在安装时为我们生成"jenkins"用户, 没有配置后台驻留程序, 因此需要我们手动启动. 启动方式也容易.
```sh
open /Applications/Jenkins/jenkins.war
```
  一句命令就能搞定了.
  如果要想指定端口或者其他参数什么的. 可以用`java`来启动这个 jar 文件.并在后面附上启动参数:
```sh
java -jar /Applications/Jenkins/jenkins.war --httpPort=8080
```

3. 配置 Jenkins 开机启动
  说了这么多, 难道每次开机都需要手动输入命令? 每次登陆用户才能启动? 别着急, 这里当然有解决方案.

  MacOS 在系统启动时会执行一系列的 app ,包括系统内部程序, 而这些启动项则以`plist` 的形式注册.这里可以把 jenkins 也注册成开机启动程序呀. 不过这里有个概念需要区分`LaunchDaemon`和`LaunchAgent`, `LaunchDaemons`是在系统启动后执行, 而`LaunchAgents`则是用户登录后执行,  这里怎么注册取决于各自的需求.

  `/System/Library/LaunchDaemons`和`/System/Library/LaunchAgents`就别想啦, 压根不给你写入机会. 据说可以通过关闭系统安全模式的方式进行, 但这样可能会导致系统安全风险, 这里也没必要, 因此这里只对`/Library/LaunchDaemon`和`/Library/LaunchAgents`进行操作.

* 这里以`LaunchDaemon`为例,执行命令:

```sh
cd /Library/LaunchDaemon/
# plist的名字可以随意定义, 这里习惯性命名成这样
touch org.jenkins-ci.plist
# 这里使用Sublime Text打开编辑的, 随你喜好,vim啦什么都可以.
open -a Sublime\ Text org.jenkins-ci.plist
```

* 在`plist`内输入以下内容:

```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
  <dict>
  	<key>Label</key>
  	<string>org.jenkins-ci</string>
  	<key>ProgramArguments</key>
  	<array>
  		<string>java</string>
  		<string>-jar</string>
  		<string>/Applications/Jenkins/jenkins.war</string>
  		<string>--httpPort=8080</string>
  	</array>
  	<key>OnDemand</key>
  	<false/>
  	<key>RunAtLoad</key>
  	<true/>
  	<key>SessionCreate</key>
  	<true/>
  	<key>UserName</key>
  	<string>你的用户名</string>
  </dict>
  </plist>
```

  这里解释下字段的意思:

  `Label`是指当前daemon的id,可在系统中查询到.可以随意定义, 只要保证自己需要的时候能查询得到就好.

  `ProgramArguments`则是启动`jenkins.war`时候所需要的命令, 这里包括指定了端口号为`8080`.

  `OnDemand`与`RunAtLoad`则是给系统判断是否需要执行

  `UserName`为登录用户, 指定执行这个启动的用户

  `SessionCreate`则是启动后创建会话用的, 不使用这个字段, 即使指定了`UserName`也无法读取login钥匙串.

  * 配置并启动 jenkins

```sh
# 添加
sudo launchctl load -w /Library/LaunchDaemons/org.jenkins-ci.plist

# 移除
sudo launchctl unload -w /Library/LaunchDaemons/org.jenkins-ci.plist

# 查看启动项是否已经有 jenkins 了
sudo launchctl list | grep jenkins
```

  如果在执行`launchctl`时出现了`Dubious ownership on file`这种错误, 则说明当前`plist`的`owner`存疑, 直接把他送给`root`用户好啦:
```sh
sudo chown root /Library/LaunchDaemons/org.jenkins-ci.plist
```

  有关 `LaunchDaemon` 的更多细节请参考[苹果官方文档](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html)
  或者这篇[dalao的博客](https://afoo.me/posts/2014-12-12-understanding-launch-daemons-of-macosx.html)

## 二、Jenkins 的初始化配置
终于安装好了Jenkins， 那么到了使用它的时候了。
打开浏览器，输入`localhost:8080`(这个`8080`端口是启动的时候设置的， 没设置默认也是`8080`, 如果设置成了别的值请自行替换), 即可进入 Jenkins 的映射网页。

![jenkins-install-04](/upload_imgs/jenkins-install/jenkins-install-04.png)

刚进来显示的就是需要管理员密码。但我们没有创建管理员, 那哪儿来的密码呢?其实这里Jenkins初始化的时候已经生成了一个随机密码, 这里直接打开`Finder`然后`Shift+CMD+G`输入`Users/当前用户名/.jenkins/secret/`就能看到:

![jenkins-install-05](/upload_imgs/jenkins-install/jenkins-install-05.png)

打开`initialAdminPassword`复制里面的内容并粘贴至密码输入框即可成功通过验证。进入插件安装页面:

![jenkins-install-06](/upload_imgs/jenkins-install/jenkins-install-06.png)

这里有`安装推荐插件`和`自定义插件安装`, 自行选择即可。

如果一个插件都安装不了，提示` No such plugin: xxxxxxx` ，请检查网络是否连通，最好开个梯子什么的， 打开浏览器输入 <http://localhost:8080/restart> 点击`YES`重启 Jenkins 后再次尝试。

如果只是个别插件安装失败， 如下图：

![jenkins-install-07](/upload_imgs/jenkins-install/jenkins-install-07.png)

可以点击`Retry`再次尝试或`Continue`直接进入主界面，在`系统管理>插件管理`中再次选择安装。

安装插件完成, 可以看到:

![jenkins-install-09](/upload_imgs/jenkins-install/jenkins-install-09.png)

点击`Start using Jenkins`即可进入主界面。

![jenkins-install-10](/upload_imgs/jenkins-install/jenkins-install-10.png)
