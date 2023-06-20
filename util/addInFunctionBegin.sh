#!/bin/bash
#在每个函数下插入一行代码

IFS="
"
file=$1
log="DBUG_TRACE;"



	#op
	#sed -i 's/[/][/].*//g' $file
	#sed -i '/^$/d' $file
	numA=$(grep -nA 1 ")" $file | grep -wv "if\|else\|while\|try\|catch\|for\|switch" | grep -v "//" |grep "{"|grep -v "int\|void\|bool\|char\|double\|float\|long\|short\|unsigned\|string"|grep "[0-9]-"|awk -F "-" '{print $1}')
	tmp=0
	for line in $numA
	do
	    fun_line=$((line-1))
	    fun=$(sed -n "$fun_line p" $file | grep -wv "if\|else\|while\|try\|catch\|for\|switch")
	    if [ ! -z "$fun" ];then
	       sed -i "$(($line)) s/{/{$log/1" $file
	   fi
	done

	numB=$(grep -nA 1 ")" $file | grep -wv "if\|else\|while\|try\|catch\|for\|switch\|DEBUG_P" | grep -v "//" | grep "{" | grep -v "[0-9]-" |grep "int\|void\|bool\|char\|double\|float\|long\|short\|unsigned\|string"| sed 's/{.*//g' )
	tmp=0
	for line in $numB
	do
	     fun_line=$(echo $line | awk -F ":" '{print $1}')
	     fun=$(echo $line | awk -F ":" '{print $2}'| grep -wv "if\|else\|while\|try\|catch\|for\|switch")
	     if [ ! -z "$fun" ];then
	        sed -i "$(($fun_line)) s/{/{$log/1" $file
	     fi
	done
