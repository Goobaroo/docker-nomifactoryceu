FROM openjdk:8u312-jre

LABEL version="1.7.7"
LABEL homepage.group=Minecraft
LABEL homepage.name="Nomifactory CEu"
LABEL homepage.icon="https://media.forgecdn.net/avatars/1168/150/638738915756848436.png"
LABEL homepage.widget.type=minecraft
LABEL homepage.widget.url=udp://Nomifactory-CEu:25565
RUN apt-get update && apt-get install -y curl unzip && \
 adduser --uid 99 --gid 100 --home /data --disabled-password minecraft

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

USER minecraft

VOLUME /data
WORKDIR /data

EXPOSE 25565/tcp

CMD ["/launch.sh"]

ENV MOTD "Nomifactory-CEu Server Powered by Docker"
ENV LEVEL world
ENV JVM_OPTS "-Xms3072m -Xmx4096m"