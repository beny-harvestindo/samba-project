#!/bin/bash

if [ $DOCKER_DEBUG = 1 ]; then
  ls -lrt / | grep docker
  ls -lrt /.docker
fi

if [ -f /.docker/config ]; then
  source /.docker/config
fi

if [ -f /.docker/init.sh ]; then
  source /.docker/init.sh
fi

if [ -f /.docker/setup ]; then
  echo ''
else
  if [ -f /.docker/setup.sh ]; then
    source /.docker/setup.sh
  fi
fi

if [ -f /.docker/service.sh ]; then
  source /.docker/service.sh
fi

