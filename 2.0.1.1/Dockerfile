FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF

ENV PANDOC_VERSION="2.0.1.1"

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Pandoc" \
      org.label-schema.description="Pandoc container including PDFLaTeX to build PDFs from Markdown" \
      org.label-schema.url="https://github.com/baez90/Docker-Pandoc" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/baez90/Docker-Pandoc" \
      org.label-schema.vendor="Peter Kurfer" \
      org.label-schema.version=$PANDOC_VERSION \
      org.label-schema.schema-version="1.0" \
      maintainer="peter.kurfer@gmail.com"

ADD https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux.tar.gz /tmp

RUN sed -i -e 's/v3\.2/edge/g' /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update texlive-full texmf-dist ghostscript && \
    rm -rf /var/cache/apk/* && \
    tar -xf /tmp/pandoc-${PANDOC_VERSION}-linux.tar.gz -C /tmp && \
    mv /tmp/pandoc-${PANDOC_VERSION}/bin/* /usr/bin/ && \
    adduser pandoc -D -s /bin/sh

ENTRYPOINT [ "/bin/sh" ]

USER pandoc
WORKDIR /home/pandoc
