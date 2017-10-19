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