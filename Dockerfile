FROM withinboredom/consul-agent

MAINTAINER Robert Landers <landers.robert@gmail.com>

ENV SYNCTHING_VERSION v0.11.6
ENV SYNCTHING_CLI_VERSION unknown
ENV FILEWATCH_VERSION v0.6.3
ENV VOL all
ENV STENDPOINT "http://127.0.0.1:8080"

RUN curl -sSLO https://github.com/syncthing/syncthing/releases/download/${SYNCTHING_VERSION}/syncthing-linux-amd64-${SYNCTHING_VERSION}.tar.gz && \
    tar -xvf syncthing-linux-amd64-${SYNCTHING_VERSION}.tar.gz && \
    cd syncthing-linux-amd64-${SYNCTHING_VERSION} && \
    mv syncthing /usr/local/bin/syncthing && \
    mkdir -p /data && \

	curl -sSLO http://build.syncthing.net/job/syncthing-cli/lastSuccessfulBuild/artifact/syncthing-cli-linux-amd64.tar.gz && \
	tar -xvf syncthing-cli-linux-amd64.tar.gz && \
	cd syncthing-cli-linux-amd64 && \
	mv syncthing-cli /usr/local/bin/syncthing-cli && \

	curl -sSLO https://github.com/syncthing/syncthing-inotify/releases/download/${FILEWATCH_VERSION}/syncthing-inotify-linux-amd64-${FILEWATCH_VERSION}.tar.gz && \
	tar -xvf syncthing-inotify-linux-amd64-${FILEWATCH_VERSION}.tar.gz && \
	mv syncthing-inotify /usr/local/bin/syncthing-inotify && \

	echo fs.inotify.max_user_watches=204800\n >> /etc/sysctl.conf && \

	curl -sSLO https://github.com/stedolan/jq/releases/download/jq-1.5rc1/jq-linux-x86_64-static && \
	mv jq-linux-x86_64-static jq && \
	chmod +x jq && \
	mv jq /usr/local/bin/jq

VOLUME ["/data/Sync"]

WORKDIR /data

ADD root /

EXPOSE 8080