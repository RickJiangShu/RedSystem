#!/bin/sh
#从预仓库导入到仓库

source ./CheckConfig.sh


if [ -f $WAREHOUSE_VERSION_FILE ]
then
	#进行差异导入
else
	#全部导入

fi
