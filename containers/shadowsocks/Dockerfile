FROM ubuntu:18.04

#Prepare repositories for apt install
RUN apt-get update \
&& apt-get install shadowsocks-libev -y --no-install-recommends \
&& rm -rf /var/lib/apt/lists/* 

# apt-get upgrade
RUN apt-get upgrade -y

# Clean up
RUN apt autoremove \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /etc/apt/sources.list.d/*

#copy shadowsocks config file
ADD ./config.json /etc/shadowsocks-libev/

#Start Shadowsocks service
CMD service shadowsocks-libev restart && tail -f /dev/null
