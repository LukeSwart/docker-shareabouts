#!/bin/bash

# assumes that we have a "raingardens" container already deployed
DOCKER_REPO="$1"
echo "Docker repo: $DOCKER_REPO"


if [[ "$1" == "lukeswart/nginx-duwamish" ]]; then
    echo "killing container:"
    docker kill nginx-duwamish
    echo "removing container:"
    docker rm nginx-duwamish

    docker run -d \
           --name "nginx-duwamish" \
           --volumes-from duwamish_flavor \
           --link duwamish_flavor:duwamish_flavor \
           -p 80:80 \
           -it $DOCKER_REPO

#           -p 443:443 \
#           -p 9090:9090 \
#           --link duwamish_flavor:duwamish_flavor \
#           --link geoserver:geoserver \
           # -it lukeswart/duwamish-nginx
# else # "lukeswart/nginx-raingardens"
elif [[ "$1" == "lukeswart/nginx-raingardens" ]]; then
    echo "killing container:"
    docker kill nginx-raingardens
    echo "removing container:"
    docker rm nginx-raingardens

    docker run -d \
           --name "nginx-raingardens" \
           --volumes-from raingardens \
           --link raingardens:raingardens \
           -p 80:80 \
           -it $DOCKER_REPO
else
    echo "docker repo not recognized: $DOCKER_REPO"

fi
