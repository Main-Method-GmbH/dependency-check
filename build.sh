#!/bin/sh -x

set -e

IMAGE="mainmethod/dependency-check"
DC_VERSION_MAJOR=5
DC_VERSION_MINOR=3
DC_VERSION_PATCH=2
DC_VERSION_MAJOR_MINOR=${DC_VERSION_MAJOR}.${DC_VERSION_MINOR}
DC_VERSION_FULL=${DC_VERSION_MAJOR_MINOR}.${DC_VERSION_PATCH}

docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}
docker build --cache-from mainmethod/dependency-check --build-arg DEPENDENCY_CHECK_VERSION=${DC_VERSION_FULL} \
  --build-arg RANDOM=${RANDOM} -t ${IMAGE} -t ${IMAGE}:${DC_VERSION_MAJOR} -t ${IMAGE}:${DC_VERSION_MAJOR_MINOR} \
  -t ${IMAGE}:${DC_VERSION_FULL} .

docker push ${IMAGE}
docker push ${IMAGE}:${DC_VERSION_MAJOR}
docker push ${IMAGE}:${DC_VERSION_MAJOR_MINOR}
docker push ${IMAGE}:${DC_VERSION_FULL}

docker logout