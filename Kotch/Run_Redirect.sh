0#!/system/bin/sh
# Cloud Configuration
# 酷安@阿巴酱(Petit Abba)
# 所有路径都已验证(√)
Version="202301111606"

#绝对路径
if [[ -d /data/adb/modules/Third_Party_Redirect ]]; then
	#Magisk
	Absolute_Path="/data/adb/modules/Third_Party_Redirect"
else
	#Magisk Lite
	Absolute_Path="/data/adb/lite_modules/Third_Party_Redirect"
fi

MODDIR="$(dirname $(readlink -f "$0"))"
[[ -f ${MODDIR}/files/Variable.sh ]] && . ${MODDIR}/files/Variable.sh
[[ -d /storage/emulated/0/Download ]] && path="Download" || path="download"
[[ ! -z $(which curl) ]] && Binary_System="$(which curl)" || Binary_System="$(which wget)"
MyPrintt() { [[ "${MODDIR}" == "${Absolute_Path}" ]] && echo "${@}" > ${DirectionalPath}/$Version.txt ; }
MyPrint() { [[ "${MODDIR}" == "${Absolute_Path}" ]] && echo "${@}" >> ${DirectionalPath}/$Version.txt || echo "${@}" ; }

DirectionalPath="/storage/emulated/0/${path}/第三方应用下载目录/-定向记录与配置"
[[ ! -d ${DirectionalPath} ]] && mkdir -p ${DirectionalPath}
[[ ! -f ${DirectionalPath}/-定向黑名单.conf ]] && { echo '# 把不需要定向的文件夹名称填写进来（一行一个）

OFF="
#举两个例子


"' > ${DirectionalPath}/-定向黑名单.conf
}

[[ "${MODDIR}" == "${Absolute_Path}" ]] && [[ ! -d ${DirectionalPath} ]] && mkdir -p ${DirectionalPath}
[[ "${MODDIR}" == "${Absolute_Path}" ]] && [[ ! -f ${DirectionalPath}/$Version.txt ]] && MyPrintt "BinaryFile: ${Binary_System}
你的设备: $(getprop ro.product.manufacturer) $(getprop ro.product.model) 安卓$(getprop ro.build.version.release)
模块名称: $(cat "${MODDIR}/module.prop" | grep 'name=' | awk -F '=' '{print ${2}}')
模块版本: $(cat "${MODDIR}/module.prop" | grep 'version=' | awk -F '=' '{print ${2}}')
文件版本: ${Version}
云端同步: $(date "+%Y-%m-%d %H:%M")

查看说明: 
[1]＝[ 定向成功 ]
[0]＝[ 存在这个路径 但识别到该路径没有用户下载的文件 所以不执行定向 ]
[rm]＝[ 删除指定路径空文件夹 ]
[off] = [ 跳过定向 ]

"
MyPrint ">>开始执行<<"

# 影响正确判断用户是否下载文件到目录的无用文件夹
Dung=".tmp
.thumbnails
.trooptmp
.Application"
for S in ${Dung}; do
	[[ -d /data/media/0/QQBrowser/$S ]] && rm -rf /data/media/0/QQBrowser/$S
	[[ -d /data/media/0/Android/data/com.tencent.mtt/sdcard/QQBrowser/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.mtt/sdcard/QQBrowser/$S
	[[ -d /data/media/0/tencent/QQfile_recv/$S ]] && rm -rf /data/media/0/tencent/QQfile_recv/$S
	[[ -d /data/media/0/Tencent/TIMfile_recv/$S ]] && rm -rf /data/media/0/Tencent/TIMfile_recv/$S
	[[ -d /data/media/0/Android/data/com.tencent.tim/Tencent/TIMfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.tim/Tencent/TIMfile_recv/$S
	[[ -d /data/media/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv/$S
	[[ -d /data/media/0/Android/data/com.tencent.tim/sdcard/Tencent/TIMfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.tim/sdcard/Tencent/TIMfile_recv/$S
	[[ -d /data/media/0/Android/data/com.tencent.mobileqq/sdcard/tencent/QQfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.mobileqq/sdcard/tencent/QQfile_recv/$S
done

source ${DirectionalPath}/-定向黑名单.conf

#应用
Download() {
	local a="/data/media/0/${2}"
	local aa="/data/media/0/Android/data/${2}"
	local aaa="${2}"
	local b="/data/media/0/${path}/第三方应用下载目录/${1}"
	local c="/storage/emulated/0/${path}/第三方应用下载目录/${1}"

	UMOUNT() {
		umount ${a} >/dev/null 2>&1
		umount ${aa} >/dev/null 2>&1
		umount ${aaa} >/dev/null 2>&1
		umount ${b} >/dev/null 2>&1
		umount ${c} >/dev/null 2>&1
	}

	for NonExecution in $OFF; do
		if [[ ${1} == $NonExecution ]]; then
			[[ ! -z ${a} ]] && [[ -d ${a} ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[off] ${1}(${a})"
			[[ ! -z ${aa} ]] && [[ -d ${aa} ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[off] ${1}(${aa})"
			[[ ! -z ${aaa} ]] && [[ -d ${aaa} ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[off] ${1}(${aaa})"
			if [[ -d ${b} ]]; then
				UMOUNT
				rm -rf ${b} && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[rm] ${b}"
			fi
			return
		fi
	done

	PathLink() {
		if [[ "$(ls -A "${L//'?'/' '}")" == "" ]]; then
			if [[ -d ${b} ]]; then
				UMOUNT
				rm -rf ${b} && return 2
			fi
			return 0
		else
			[[ ! -d "${b}" ]] && mkdir -p "${b}"
			mount --bind "${L}" "${b}"
			mount --bind "${L}" "${c}"
			chcon u:object_r:media_rw_data_file:s0 "${L}"
			chmod 777 "${b}"
			chown media_rw:media_rw "${b}"
			chown media_rw:media_rw "${c}"
			return 1
		fi
	}

	if [[ -d ${a} ]]; then
		L="${a}"
		PathLink
		[[ $? == 1 ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[1] ${1}(${L})" || MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[0] ${1}(${L})"
		[[ $? == 2 ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[rm] ${b}"
	elif [[ -d ${aa} ]]; then
		L="${aa}"
		PathLink
		[[ $? == 1 ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[1] ${1}(${L})" || MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[0] ${1}(${L})"
		[[ $? == 2 ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[rm] ${b}"
	elif [[ -d ${aaa} ]]; then
		L="${aaa}"
		PathLink
		[[ $? == 1 ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[1] ${1}(${L})" || MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[0] ${1}(${L})"
		[[ $? == 2 ]] && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[rm] ${b}"
	fi
}


# 正常默认下载目录
Download 'QQ' 'Android/data/com.tencent.mobileqq/Tencent/QQfile_recv'
Download 'QQ图片1' 'Android/data/com.tencent.mobileqq/Tencent/QQ_Images/QQEditPic'
Download 'QQ图片2' 'Android/data/com.tencent.mobileqq/sdcard/Tencent/QQ_Images'
Download 'QQ图片2' 'Android/data/com.tencent.mobileqq/sdcard/tencent/QQ_Images'
Download 'QQ已发送文件' 'Android/data/com.tencent.mobileqq/cache/share'
Download '微信' 'Android/data/com.tencent.mm/MicroMsg/Download'
Download '阿里云盘' 'Android/data/com.alicloud.databox/sdcard/AliYunPan'
Download '百度网盘' 'Android/data/com.baidu.netdisk/sdcard/BaiduNetdisk'
Download '.TG' 'Android/data/org.telegram.messenger/files/Telegram'
Download '酷安' 'Android/data/com.coolapk.market/files/Download'
Download 'IDM' 'Android/data/idm.internet.download.manager.plus/sdcard/IDMP/General'
Download '夸克' 'Android/data/com.quark.browser/sdcard/Quark/Download'
Download '115网盘' '/storage/emulated/0/Android/data/com.ylmf.androidclient/sdcard/115yun/download'


wjj="/data/media/0/${path}/第三方应用下载目录/*
/storage/emulated/0/${path}/第三方应用下载目录/*"

for i in `ls -d ${wjj}`; do
	kwjj=${i}
	if [[ "$(ls -A "${kwjj//'?'/' '}" 2>/dev/null)" == "" ]]; then
		if [[ -d ${kwjj} ]]; then
			umount ${kwjj} >/dev/null 2>&1
			rm -rf ${kwjj} 2>/dev/null && MyPrint "$(date "+[%Y-%m-%d %H:%M:%S]"):[rm] ${kwjj}"
		fi
	fi
done

MyPrint ">>执行完毕<<"

if [[ ! -f ${Absolute_Path}/files/.Judgement1 ]]; then
	echo "#!/system/bin/sh
	if [[ -f ${DirectionalPath}/-定向黑名单.conf.bak ]]; then
		rm -rf ${DirectionalPath}/-定向黑名单.conf.bak
	fi
	{
		sh ${0}
	}&" > ${DirectionalPath}/-一键执行.sh
	touch ${Absolute_Path}/files/.Judgement1
fi

sleep 10
