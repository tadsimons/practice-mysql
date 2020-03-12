#!/bin/bash

export MYSQL_PWD=232323

for ((i=1; i<=10000000; i ++))
do
	/usr/local/mysql/bin/mysql -u root -e "INSERT INTO test.dev_info(dev_id, temp, info) VALUES($i, $i, '这台设备很不错');" &
        echo $i
done

