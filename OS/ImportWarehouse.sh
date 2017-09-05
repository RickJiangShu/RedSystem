#!/bin/sh
#从预仓库导入到仓库

source ./CheckConfig.sh

#写入版本
function WriteVersion()
{
	version=`svn info $PRE_WAREHOUSE_PATH |grep Revision: |cut -c11-`
	echo $version > $WAREHOUSE_VERSION_FILE
}

function ImportAll()
{
	#导入UI图片
	UITextureSource="$PRE_WAREHOUSE_PATH/UITexture"
	cp -rf $UITextureSource $WAREHOUSE_PATH
	WriteVersion
	return 0
}

if [ -f $WAREHOUSE_VERSION_FILE ]
then
	preVersion='svn info $PRE_WAREHOUSE_PATH |grep Revision: |cut -c11-'
	version=`cat $WAREHOUSE_VERSION_FILE`
	if [ preVersion == version ]
	then
		echo "版本相同，不进行导入..."
	else
		echo "差异导入$version"
	fi
else
	#全部导入
	read -r -p "找不到$WAREHOUSE_VERSION_FILE，是否确定要全部导入？[y/n]" input
	case $input in
		[yY][eE][sS]|[yY])
			ImportAll
			;;
		[nN][oO]|[nN])
			echo "Exit..."
			;;
		*)
			echo "Invalid input..."
			;;
	esac
fi

