FROM debian

MAINTAINER Adriaan de Jonge <adejonge@xebia.com>

ENV version 4.7.0
RUN apt-get update
RUN apt-get install -y openjdk-7-jre-headless unzip wget --no-install-recommends


RUN wget https://download.xebialabs.com/files/Generic/xl-release-${version}-server.zip -O /tmp/xlr.zip && unzip /tmp/xlr.zip -d /opt && rm /tmp/xlr.zip
ADD xlrelease.answers /opt/xl-release-${version}-server/bin/xlrelease.answers
ADD xl-release-license.lic /opt/xl-release-${version}-server/conf/xl-release-license.lic

WORKDIR /opt/xl-release-${version}-server/bin
RUN ["./server.sh", "-setup", "-reinitialize", "-force", "-setup-defaults", "./bin/xlrelease.answers"]

VOLUME /opt/xl-release-${version}-server/conf
VOLUME /opt/xl-release-${version}-server/ext
VOLUME /opt/xl-release-${version}-server/hotfix
VOLUME /opt/xl-release-${version}-server/importablePackages
VOLUME /opt/xl-release-${version}-server/log
VOLUME /opt/xl-release-${version}-server/plugins
VOLUME /opt/xl-release-${version}-server/repository

EXPOSE 55555
CMD ["./server.sh"]
