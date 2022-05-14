#!/bin/sh
cd /server
sleep 1

if [ "${STEAM_USER}" == "" ]; then
    STEAM_USER=anonymous
    STEAM_PASS=""
    STEAM_AUTH=""
fi

## Install MSRebrith and check for updates.
chmod u+x steamcmd/steamcmd.sh
./steamcmd/steamcmd.sh +force_install_dir +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +app_update 1961680 +quit

## Make steam_appid.txt readonly
chmod 444 /mnt/server/steam_appid.txt

./hlds_run "$@"