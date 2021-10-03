#!/bin/bash

cd /home/docker &&
curl -sL https://savilelee.github.io/Profiles/Portainer-CN/install/Public-files.tar.gz | tar xz &&
rm -rf public &&
mv Public-files public &&
docker stop portainer &&
docker rm portainer &&
docker rmi portainer/portainer &&
docker rmi portainer/portainer-ce &&
docker run -d --restart=always --name="portainer" -p 1314:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer:/data -v /home/docker/public:/public portainer/portainer-ce