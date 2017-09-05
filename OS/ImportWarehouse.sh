#!/bin/sh
#从预仓库导入到仓库

source ./CheckConfig.sh

#用于按换行符切割字符串并返回一个数组
function SetIFS()
{
	LAST_IFS="$IFS"
	IFS=$'\x0A'
}
function RevertIFS()
{
	IFS="$LAST_IFS"
}

function ImportAll()
{
	#导入UI图片
	UITextureSource="$PRE_WAREHOUSE_PATH/UITexture"
	UITextureDestination="$WAREHOUSE_PATH/UITexture"
	cp -ru $UITextureSource/* $UITextureDestination

	#检查Source是否已经没有Destination的相关文件
	onlyStr="Only in $UITextureDestination"
	onlyLength=${#onlyStr}
	diffStr=`diff -r $UITextureSource $UITextureDestination`

	SetIFS
	diffArr=($diffStr)
	for s in ${diffArr[@]}
	do
		#忽略.meta文件
		[[ $s =~ ".meta" ]] && continue

		checkOnlyStr=${s:0:$onlyLength}
		if [ "$checkOnlyStr" == "$onlyStr" ]; then
			onlyFilePath=${s:8}
			onlyFilePath=${onlyFilePath/: //}
			rm $onlyFilePath
		fi
	done
	RevertIFS

	return 0
}

if [ -f $WAREHOUSE_VERSION_FILE ]
then
	#进行差异导入
	echo "差异导入"
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

