FROM debian:bullseye-slim

WORKDIR /snell

RUN apt update \
  && apt install -y wget unzip pwgen \
  && wget https://dl.nssurge.com/snell/snell-server-v4.0.0-linux-amd64.zip \
  && unzip snell-server-v4.0.0-linux-amd64.zip -d ./ \
  && mkdir config \
  && echo -e "[snell-server]\nlisten = 0.0.0.0:10990\npsk = $(pwgen -s 20 1)\nipv6 = false" > ./config/config.json \
  && rm snell-server-v4.0.0-linux-amd64.zip \
  && apt purge -y --auto-remove wget unzip pwgen

# ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["snell-server" "-c" "/snell/config/snell-server.conf"]
