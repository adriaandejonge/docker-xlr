FROM java:8u77-jre-alpine

MAINTAINER Adriaan de Jonge <adejonge@xebia.com>

ENV version 5.0.0
ENV root /lib
ENV home ${root}/xl-release-${version}-server 

RUN wget \
      https://dist.xebialabs.com/public/trial/xl-release/xl-release-${version}-server.zip \
      -O /tmp/xlr.zip \
  && unzip \
      /tmp/xlr.zip \
      -d ${root} \
  && rm -R \
      /tmp/xlr.zip \
      ${home}/serviceWrapper 
      
ADD xlrelease.answers ${home}/bin/xlrelease.answers

WORKDIR ${home}/bin
RUN ["./run.sh", "-setup", "-reinitialize", "-force", "-setup-defaults", "./bin/xlrelease.answers"]

VOLUME ["${home}/conf", \ 
	"${home}/ext", \
	"${home}/hotfix", \ 
	"${home}/importablePackages", \
	"${home}/log", \
	"${home}/plugins", \ 
	"${home}/repository"]

EXPOSE 5516

CMD ["./run.sh"]
