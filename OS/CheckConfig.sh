#!/bin/sh
#用来检测配置是否正确
source ./Config


if [ ! -d $PRE_WAREHOUSE_PATH ]
then
	echo "$PRE_WAREHOUSE_PATH 没有找到！"
	exit 1
fi

if [ ! -d $WAREHOUSE_PATH ]
then
	echo "$WAREHOUSE_PATH 没有找到！"
	exit 1
fi

