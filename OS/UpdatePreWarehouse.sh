#!/bin/sh
#更新预仓库

source ./Config

svn cleanup $PRE_WAREHOUSE_PATH
svn update $PRE_WAREHOUSE_PATH --username jiangshu --password jiangshu

