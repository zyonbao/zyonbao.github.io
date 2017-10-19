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

在源码管理中，Git 的 `Branches to build`项用上文添加的参数`BRANCH`即可。这样， `构建`选项就会变成`使用参数构建`，就可以选择分支进行构建了。
![jenkins-shell-01](/upload_imgs/jenkins-shell/jenkins-shell-01.png)
在构建部分，添加了两个`Execute shell`操作，第一个很简单，就是`pod install`的脚本。如下图：
![jenkins-shell-02](/upload_imgs/jenkins-shell/jenkins-shell-02.png)
第二部分则比较复杂。这个脚本主要实现了根据`ExportExportOptions.plist`打包，并且根据当前日期设置	`export`出的文件名参数, 并导出到固定位置。
![jenkins-shell-03](/upload_imgs/jenkins-shell/jenkins-shell-03.png)
具体脚本如下，里面注释已经写很多啦， 这里不在赘述。直接看代码：
```shell
#!/bin/sh
export LANG=en_US.UTF-8     #   执行pod install时用到
security unlock-keychain "-p" "123"   # MAC授权密码
appname="operation4ios"
# build_type="dev"
projectpath=$(pwd) # 工作目录
basepath=$HOME # 当前用户目录
archivePath="$projectpath/archive/$appname.xcarchive" #archive目录
packagepath="$projectpath/packages" # ipa文件存放的路径
# ExportIpa时的依据的plist文件路径
optionsPlist="$projectpath/ExportOptions/ExportOptions.plist"
# 项目所在的 plist 文件路径
info_plist="$projectpath/$appname/Info.plist"
export_ipapth="$basepath/Share/" # 最终转存导出的ipa路径
export_ipaname="iSolarCloud" # 最终转存导出的ipa文件名

# 根据当前日期设置 build 号
# current_time=$(date +%Y%m%d_%H:%M:%S) #获取当前日余额时分秒
current_date=`date +%y%m%d`
#获取并设置build版本号
build_num=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "$info_plist")
slice_date=${build_num:0:6}
if [ ${slice_date} -ge $current_date ]
then
   build_num=`expr ${build_num} + 1`
else
   build_num="${current_date}01"
fi
/usr/libexec/PlistBuddy -c "Set CFBundleVersion $build_num" "$info_plist"
#设置 sys-clientVersion
client_version=`/usr/libexec/PlistBuddy -c "Print sys-clientVersion" "$info_plist"`
big_version=${client_version%.*}
if [ "${big_version}" = "" ]
then
	big_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$info_plist"`
fi
new_client_version="${big_version}.${build_num}"
/usr/libexec/PlistBuddy -c "Set sys-clientVersion ${new_client_version}" "$info_plist"

# 获取 shortVersion
bundle_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$info_plist"`

# 确定ipa路径和ipa名称
ipaname_prefix="${appname}_${new_client_version}_${build_type}" #ipa所在文件夹的 name
ipapath="$packagepath/$ipaname_prefix" # 导出ipa的路径

#clean
xcodebuild -workspace "$appname.xcworkspace" -scheme "$appname" -configuration "Debug" clean
#build
xcodebuild archive -workspace "$appname.xcworkspace" -scheme "$appname" -sdk iphoneos -configuration "Debug" -archivePath $archivePath
#export
xcodebuild -exportArchive -archivePath "$archivePath" -exportPath "$ipapath" -exportOptionsPlist "$optionsPlist" -allowProvisioningUpdates

# 移动ipa文件并删除编译文件夹
cd $packagepath
mv $ipapath/$appname.ipa $export_ipapth/${export_ipaname}_V$bundle_version\(build$build_num\).ipa # 按命名格式将文件重命名
# rm -rf *.ipa || true # 删除旧的ipa文件
rm -rf $ipapath # 删除空目录
```
[shell脚本下载](/upload_res/buildexport.sh)



