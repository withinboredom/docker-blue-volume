#!/bin/bash
#/vagrant/ubuntu-base/build.sh
#/vagrant/consul/build.sh
#/vagrant/consul-ui/build.sh
#/vagrant/consul-agent/build.sh

docker tag -f withinboredom/consul-agent withinboredom/blue-volume:base
docker build -t withinboredom/blue-volume:latest blue-volume
#docker push withinboredom/blue-volume