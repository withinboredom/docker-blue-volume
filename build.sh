#!/bin/bash
/vagrant/ubuntu-base/build.sh
/vagrant/consul/build.sh
/vagrant/consul-ui/build.sh
/vagrant/consul-agent/build.sh


docker build -t withinboredom/blue-volume /vagrant/blue-volume
docker push withinboredom/blue-volume