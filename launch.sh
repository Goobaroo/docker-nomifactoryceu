#!/bin/bash

set -x

cd /data

FORGE_VERSION=1.12.2-14.23.5.2860

if ! [[ "$EULA" = "false" ]] || grep -i true eula.txt; then
	echo "eula=true" > eula.txt
else
	echo "You must accept the EULA by in the container settings."
	exit 9
fi

if ! [[ -f nomi-ceu-1.7-alpha-1-server.zip ]]; then
	rm -fr bansoukou config config-overrides groovy libraries local mods scripts *.jar *.zip
	curl -Lo nomi-ceu-1.7-alpha-1-server.zip 'https://edge.forgecdn.net/files/4814/352/nomi-ceu-1.7-alpha-1-server.zip' && unzip -u -o nomi-ceu-1.7-alpha-1-server.zip -d /data
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' > ops.txt
fi
if [[ -n "$ALLOWLIST" ]]; then
    echo $ALLOWLIST | awk -v RS=, '{print}' > white-list.txt
fi

SERVER_JAR=$(ls forge-*.jar)
JVM_OPTS=$JVM_OPTS $JAVA_PARAMETERS
curl -Lo log4j2_112-116.xml https://launcher.mojang.com/v1/objects/02937d122c86ce73319ef9975b58896fc1b491d1/log4j2_112-116.xml
java -server $JVM_OPTS -Dfml.queryResult=confirm -Dlog4j.configurationFile=log4j2_112-116.xml -jar $SERVER_JAR nogui