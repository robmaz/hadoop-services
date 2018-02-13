#!/bin/bash

. /etc/hadoop/conf/basic-env.sh

srvdir=$(pkg-config systemd --variable=systemdsystemunitdir)
mkdir -p $srvdir

#install -m 600 hadoop-namenode.service $srvdir/
install -m 600 hadoop-datanode.service $srvdir/
#install -m 600 hadoop-journalnode.service $srvdir/
#install -m 600 hadoop-secondarynamenode.service $srvdir/
#install -m 600 yarn-resourcemanager.service
install -m 600 yarn-nodemanager.service $srvdir/
#install -m 600 yarn-timeline.service

systemctl reload-daemon
systemctl enable hadoop-datanode.service && systemctl start hadoop-datanode.service
systemctl enable yarn-nodemanager.service && systemctl start yarn-nodemanager.service
