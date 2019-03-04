#!/bin/bash
export CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,address=localhost:8000,server=y,suspend=n"
export JAVA_OPTS="$JAVA_OPTS"

config_file=$CATALINA_HOME/conf/server.xml
if [ "${PORT}" != "8080" ];then
  sed -i "s/8080/$PORT/g" ${config_file}
  sed -i "s/8005/$(($PORT-75))/g" ${config_file}
  sed -i "s/8009/$(($PORT-105))/g" ${config_file}
  sed -i "s/8443/$(($PORT+1000))/g" ${config_file}
fi
conf=$CATALINA_HOME/webapps/ROOT/WEB-INF/dubbo.properties
cat>$conf<<EOF
dubbo.registry.address=zookeeper://${ZK_HOST}:${ZK_PORT}
dubbo.admin.root.password=${USER}
dubbo.admin.guest.password=${PASSWORD}
EOF
echo env ......
echo ZK_HOSTNAME: $ZK_HOSTNAME
echo ZK_HOST: $ZK_HOST
echo ZK_PORT: ${ZK_PORT}
echo USER: ${USER}
echo PASSWORD: ${PASSWORD}

if [ -z "${ZK_HOSTNAME}" ];
then
echo env ZK_HOSTNAME is null
exit 
fi
echo "$ZK_HOST $${ZK_HOSTNAME} >>/etc/hosts"
catalina.sh run

