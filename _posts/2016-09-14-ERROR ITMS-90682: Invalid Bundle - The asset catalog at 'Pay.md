---
layout: post
title: '提交 Appstore 出现 ERROR ITMS-90682 的解决方案'
subtitle: '刚升级Xcode 8，幺蛾子又出现了。提交的时候出现了 ERROR ITMS-90682 '
date: 2016-09-14
categories: AppStore 提交
tags: 提交错误
---

# [ERROR ITMS-90682: Invalid Bundle - The asset catalog at 'Payload/XXXXX/Assets.car' can't contain 16-bit or P3 assets if the app supports iOS 9.3 or earlier.]

刚升级Xcode 8， 幺蛾子又出现了。提交的时候出了这个问题。 BTW，感谢google。以下为解决方案：‘

在 Xcode 8 中，当你资源文件中[含有16位图]或者[图片显示模式γ值为'P3']且iOS targets设定为iOS 9.3以下就会出现这个问题. 如果你的app需要支持广色域显示的话，那你必须得把target设置成iOS 9.3+，相反，如果你的app不需要支持广色域且你想兼容 iOS 9.3 之前的项目，你就得把所有的16位的或者显示模式为'P3'图片全都替换成8位模式的SRGB颜色的图片。



你可以通过运行`assetutil`在iTunes Connect的错误信息中找到16-bit 或 P3 资源文件。离线的解决方案如下：

1. 导出项目的`ipa`文件
2. 定位到该`ipa`文件修改后缀名.ipa 为 .zip.
3. 解压该 `.zip` 文件. 解压后的目录里面会有一个包含着你的`app bundle`文件的 `Payload` 文件夹.
4. 打开终端并切换到你的`app`的`Payload`文件夹下的`.app bundle`文件夹内，形式如下：

```shell
cd path/to/Payload/your.app
```

5. 用`find`命令定位到`Assets.car`文件`.app bundle`, 形式如下:

```shell
find . -name 'Assets.car'
```

6. 使用`assetutil`命令找到任何包含着`16-bit`or`P3`的资源文件, 对每个`Assets.car`之行以下命令 :

```shell
sudo xcrun --sdk iphoneos assetutil --info /path/to/a/Assets.car > /tmp/Assets.json
```

注：这里的`/path/to/a/Assets.car` 指的是 Assets.car 的路径，*不要*直接复制！！！使用上一步find命令的结果。

![img](/uploads/791090-20160921143640637-12978843.png)

7. 打开上一步生成的`/tmp/Assets.json`文件并查找包含有`"DisplayGamut" : "P3"`或者相关的内容.  这段json的`Name`字段对应的值就是16位或显示的γ值为P3的资源文件名.

![img](/uploads/791090-20160914172149367-1157766338.png)


8. 找到这个资源文件修改为 8位的sRGB形式,重新编译上传你的app即可.