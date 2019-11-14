FROM adoptopenjdk/openjdk11:alpine
VOLUME /tmp

RUN apk update && \
    apk add tzdata && \
    apk add curl && \
    cp /usr/share/zoneinfo/Europe/Warsaw  /etc/localtime && \
    echo "Europe/Warsaw" > /etc/timezone && \
	rm -rf /var/cache/apk/*

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
EXPOSE 3333

ARG JAR_FILE
ADD ${JAR_FILE} app.jar
RUN sh -c 'touch /app.jar'