FROM debian:buster-slim
LABEL maintainer="Anunay Kumar (kumaranunay123@gmail.com)"
ENV VERSION=6.9.6
ADD https://bintray.com/artifact/download/jfrog/artifactory/jfrog-artifactory-oss-${VERSION}.zip /
COPY entry-point.sh /
RUN chmod +x /entry-point.sh
ENTRYPOINT ["./entry-point.sh"]

