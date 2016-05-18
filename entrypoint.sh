#!/bin/bash

set -e
set -x

/usr/share/zookeeper/bin/zkServer.sh start
cd /root/nbase-arc/confmaster && ./confmaster-v1.2.5-16-g45fd2b8.sh
/etc/init.d/ssh start
sleep 5
cd /root/nbase-arc/mgmt && expect /nbase-arc/install_test_cluster.sh

exec "$@"

