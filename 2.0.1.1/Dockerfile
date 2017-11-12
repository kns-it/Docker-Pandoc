FROM alpine:edge

LABEL maintainer="peter.kurfer@gmail.com"

ENV PANDOC_VERSION="2.0.1.1"

ADD https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux.tar.gz /tmp

RUN sed -i -e 's/v3\.2/edge/g' /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update texlive texlive-xetex texmf-dist ghostscript && \
    rm -rf /var/cache/apk/* && \
    tar -xf /tmp/pandoc-${PANDOC_VERSION}-linux.tar.gz -C /tmp && \
    mv /tmp/pandoc-${PANDOC_VERSION}/bin/* /usr/bin/ && \
    adduser pandoc -D -s /bin/sh

ENTRYPOINT [ "/bin/sh" ]

USER pandoc
WORKDIR /home/pandoc
