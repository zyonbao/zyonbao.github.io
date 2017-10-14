---
layout: post
title: '配置 Jenkins + Xcode 自动打包'
subtitle: 'Jenkins 配置 Xcode 加上各种插件可以实现自动打包，是在是不可多得的利器，翻了翻网上的教程，看起来很简单吗，我也来试一试。'
cover: '/uploads/cover-2017-10-14.jpg'
date: 2017-10-14
categories: jenkins自动打包
tags: jenkins xcode CI
---

# 配置 Jenkins + Xcode 实现自动打包

## 安装 Jenkins

## 配置 Jenkins 构建环境

1. 配置构建触发器

2. 配置构建脚本-cocoapods

   ```shell
   #!/bin/bash -l
   export LANG=en_US.UTF-8
   export LANGUAGE=en_US.UTF-8
   export LC_ALL=en_US.UTF-8
   pod install --verbose --no-repo-update
   ```

   ​

3. 配置构建脚本-xcodebuild

   ```shell
   #!/bin/bash -l
   export LANG=en_US.UTF-8
   export LANGUAGE=en_US.UTF-8
   export LC_ALL=en_US.UTF-8

   xcodebuild -archivePath "/Users/sungrow/.jenkins/workspace/operation4ios/build/Debug-iphoneos/operation4ios.xcarchive" -workspace operation4ios.xcworkspace -sdk iphoneos -scheme "operation4ios" -configuration "Debug" archive

   xcodebuild -exportArchive -archivePath "/Users/sungrow/.jenkins/workspace/operation4ios/build/Debug-iphoneos/operation4ios.xcarchive" -exportPath "/Users/sungrow/.jenkins/workspace/operation4ios/build/operation4ios_debug" -exportOptionsPlist '/Users/sungrow/.jenkins/workspace/operation4ios/build/ExportOptions.plist' -allowProvisioningUpdates
   ```

   ​

## 打包

## 遇到的各种问题

