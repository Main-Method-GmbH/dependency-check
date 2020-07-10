FROM openjdk:8-jre-slim

LABEL vendor="Main Method GmbH"
LABEL name="mainmethod/dependency-check"

MAINTAINER Maik Herrmann <maik.herrmann@main-method.com>

ENV DEPENDENCY_CHECK_VERSION 5.3.2
ENV DOWNLOAD_URL=https://dl.bintray.com/jeremy-long/owasp
ENV FILE="dependency-check-${DEPENDENCY_CHECK_VERSION}-release.zip"
ENV USER=dependency-check

RUN apt-get update -qq
RUN apt-get install -qqy --no-install-recommends \
        gpg-agent \
        gpg \
        curl \
        unzip

RUN useradd -ms /bin/bash ${USER}
USER ${USER}
WORKDIR /home/${USER}
# install dependency check
RUN curl https://bintray.com/user/downloadSubjectPublicKey?username=jeremy-long | gpg --import -
RUN curl -L ${DOWNLOAD_URL}/${FILE} -o ${FILE}
RUN curl -L "${DOWNLOAD_URL}/${FILE}.asc" -o "${FILE}.asc"
RUN gpg --verify "${FILE}.asc"
RUN unzip ${FILE} && \
    rm ${FILE}

RUN ls -l
# Update dependency check database
RUN ./dependency-check/bin/dependency-check.sh --updateonly --data=${HOME}/data

VOLUME ["/input", "/output"]

ENTRYPOINT ["./dependency-check/bin/dependency-check.sh"]
CMD ["--scan=/input","--format=ALL", "--out=/output", "-n", "--data=/home/dependency-check/data", "--disableAssembly"]