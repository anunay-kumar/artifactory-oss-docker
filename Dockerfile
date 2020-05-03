FROM debian:buster-slim
LABEL maintainer="Anunay Kumar (kumaranunay123@gmail.com)"
ENV VERSION=7.4.3

RUN apt-get update && apt-get install -y wget tar dos2unix unzip gnupg software-properties-common \
	&& rm -rf /var/lib/apt/lists/*
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
	&& add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
	&& mkdir -p /usr/share/man/man1 \
	&& apt-get update \
	&& apt-get install -y adoptopenjdk-8-hotspot \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -O jfrog-artifactory-pro-${VERSION}-linux.tar.gz "https://bintray.com/standAloneDownload/downloadArtifact?product=artifactory&artifactPath=/jfrog/artifactory-pro/org/artifactory/pro/jfrog-artifactory-pro/${VERSION}/jfrog-artifactory-pro-${VERSION}-linux.tar.gz&callback_id=anonymous"

RUN ls -lrt && tar -xvf jfrog-artifactory-pro-${VERSION}-linux.tar.gz 
RUN mv artifactory-pro-${VERSION} artifactory 
RUN rm jfrog-artifactory-pro-${VERSION}-linux.tar.gz
RUN sed -ri 's/2g/512m/g' /artifactory/app/bin/artifactory.default

VOLUME /artifactory/data
VOLUME /artifactory/logs
VOLUME /artifactory/backup

EXPOSE 8081
EXPOSE 8082
EXPOSE 8046

#For Debug
COPY entry-point.sh /
RUN chmod +x /entry-point.sh && dos2unix /entry-point.sh
ENTRYPOINT ["/entry-point.sh"]

#WORKDIR /artifactory
#ENTRYPOINT ["artifactory.sh"]

