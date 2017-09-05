#!/bin/sh
#从预仓库导入到仓库

source ./CheckConfig.sh

function ImportAll()
{
	echo "ImportAll"
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
			echo "No"
			;;
		*)
			echo "Invalid input..."
			;;
	esac
fi

