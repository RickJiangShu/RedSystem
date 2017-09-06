#!/bin/bash

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
function Diff()
{
	#检查Source是否已经没有Destination的相关文件
	UITextureDestination="$WAREHOUSE_PATH/UITexture"
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
			echo "Delete Only in:$onlyFilePath"
		fi
	done
	RevertIFS
}
