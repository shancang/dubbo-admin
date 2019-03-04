FROM tomcat:latest
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && echo 'Asia/Shanghai' >/etc/timezone && rm -rf  /usr/local/tomcat/webapps/*
ADD ROOT/ /usr/local/tomcat/webapps/ROOT/
ADD ScheduleConsole/ /usr/local/tomcat/webapps/ScheduleConsole
ADD start.sh /
ENV PORT=8080 ZK_HOST=127.0.0.1   ZK_PORT=2181 USER=root PASSWORD=root
ENV ZK_HOSTNAME ""
CMD ["bash","/start.sh"]
