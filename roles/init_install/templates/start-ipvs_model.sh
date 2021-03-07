#!/bin/bash
ipvs_model=`ls /usr/lib/modules/$(uname -r)/kernel/net/netfilter/ipvs |grep -o ^[^.]*`
for m in ${ipvs_model};do
       /usr/sbin/modprobe $m
done
