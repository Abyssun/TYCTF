FROM openjdk:8
EXPOSE 8080
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ADD ./marsctf-server-0.0.1-SNAPSHOT.jar  ./marsctf-server-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "./marsctf-server-0.0.1-SNAPSHOT.jar"]
