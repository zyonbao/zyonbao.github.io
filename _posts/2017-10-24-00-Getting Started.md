---
layout: post
title: 'Yoga-00-快速开始-新手入门'
subtitle: '这是facebook出品的flexbox布局库的翻译文档的第0章第0篇'
date: 2017-10-24
cover: '/upload_imgs/coverset/2017-10-24-yoga.jpg'
categories: 翻译文档
tags: Yoga
---

# 新手入门

## 安装

Yoga 的安装目前是个手动的过程. 我们已经计划将 Yoga 带到很多可用的 package 管理系统上 (例如: [Yarn](https://yarnpkg.com/), [Gradle](https://gradle.org/), [Cocoapods](https://cocoapods.org/)), 但目前我们并没有一个明确的目标日期. 在这里我们非常感谢[社区贡献 ](https://github.com/facebook/yoga/pulls).

### 获取 Code

在这里我们建议你将 Yoga 作为你项目中的 [git 子模块](https://git-scm.com/docs/git-submodule). 这样做的好处是, 你可以使用 Buck (下面将会[介绍](https://facebook.github.io/yoga/docs/getting-started/#building-with-buck)) 来构建 Yoga, 或者通过引入 [`yoga` 根目录](https://github.com/facebook/yoga/tree/master/yoga) 的 C Library 以及你想使用的[`语言绑定`](https://github.com/facebook/yoga) (例如: Java, C#) 将其集成到现有的构建系统中.

### 运行示例代码

#### iOS

Yoga 发行中含有 [iOS 示例代码](https://github.com/facebook/yoga/tree/master/YogaKit/YogaKitSample). 用下面的命令来运行:

```shell
$ git clone https://github.com/facebook/yoga.git
$ cd open yoga/YogaKit/YogaKitSample/
$ pod install
$ open YogaKitSample.xcworkspace
```

#### Android

Yoga 发行版中也含有 [Android 示例](https://github.com/facebook/yoga/tree/master/android/sample). 用下面的命令来让它在外接设备(或模拟器)上运行:

```shell
$ git clone https://github.com/facebook/yoga.git
$ cd yoga
$ buck install -r android/sample
```

实际上, 这不仅仅是一个示例, 更是通常情况下载安卓上使用 Yoga 的一个布局系统(参考 `YogaLayout`).  有关更多信息，请参阅 [Android API](https://facebook.github.io/yoga/docs/api/android) 章节.

### 使用 Buck 构建

Yoga 使用 [Buck](https://buckbuild.com/) 作为它的构建系统. Buck 不是使用 Yoga 必须的, 但, 如果你已经在使用 Buck, 那集成 Yoga 就非常简单了.

如果你正在使用 Buck 所有你要做的就是在你的 `BUCK` 文件中引用你想使用的`语言绑定`.

``` buck
deps = [
  # C
  '//path/to/submodule/yoga:yoga',

  # Java
  '//path/to/submodule/yoga/java:jni',

  # Objective-C
  '//path/to/submodule/yoga/YogaKit:YogaKit',
]
```