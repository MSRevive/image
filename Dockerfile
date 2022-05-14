FROM debian:stable-slim

LABEL author="Team MSRebirth" maintainer="admin@msrebirth.net"

LABEL org.opencontainers.image.source="https://github.com/MSRevive/image"
LABEL org.opencontainers.image.licenses=MIT

ENV DEBIAN_FRONTEND noninteractive

VOLUME ["/server"]
WORKDIR /server
ENV HOME /server

# Install packages
RUN dpkg --add-architecture i386 \
  && apt update \
  && apt upgrade -y \
  && apt install -y libssl1.1:i386 libtinfo6:i386 libtbb2:i386 libtinfo5:i386 libcurl4-gnutls-dev:i386 libcurl4:i386 libncurses5:i386 libcurl3-gnutls:i386 libtcmalloc-minimal4:i386 faketime:i386 libtbb2:i386 libvorbisfile3 curl \
  && rm -rf /var/lib/apt/lists/*
  
# Install SteamCMD
RUN mkdir -p /server/steamcmd \
  && cd /server/steamcmd \
  && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
  && mkdir -p /server/steamapps # Fix steamcmd disk write error when this folder is missing

# SteamCMD fails otherwise for some reason, even running as root.
# This is changed at the end of the install process anyways. 
RUN chown -R root:root /server \
  && mkdir -p /server/.steam/sdk32 \
  && mkdir -p /server/.steam/sdk64 \
  # && cp -v ./linux32/steamclient.so ../.steam/sdk32/steamclient.so \
  # && cp -v ./linux32/steamclient.so ../.steam/sdk64/steamclient.so \

# We want to overwrite the include hlds_run script with ours cause of file header.
COPY ./files/hlds_run /server/
ADD ./entrypoint.sh /server/
ENTRYPOINT ["/server/entrypoint.sh"]