FROM alpine:edge

ARG BUILD_DATE
ARG VCS_REF

ENV PANDOC_VERSION="2.0.3"

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Pandoc" \
      org.label-schema.description="Pandoc container including PDFLaTeX to build PDFs from Markdown" \
      org.label-schema.url="https://github.com/kns-it/Docker-Pandoc" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kns-it/Docker-Pandoc" \
      org.label-schema.vendor="KNS" \
      org.label-schema.version=$PANDOC_VERSION \
      org.label-schema.schema-version="1.0" \
      maintainer="sebastian.kurfer@kns-it.de"

RUN sed -i -e 's/v3\.2/edge/g' /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update texlive-full texmf-dist ghostscript librsvg ttf-dejavu && \
    rm -rf /var/cache/apk/* && \
    wget -P /tmp https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux.tar.gz && \
    tar -xf /tmp/pandoc-${PANDOC_VERSION}-linux.tar.gz -C /tmp && \
    mv /tmp/pandoc-${PANDOC_VERSION}/bin/* /usr/bin/ && \
    rm -rf /tmp/* && \
    adduser pandoc -D -s /bin/sh && \
    mkdir -p /usr/share/texmf-var/tex/xelatex/common && \
    wget http://mirrors.ctan.org/macros/latex/contrib/etoolbox/etoolbox.sty -O /usr/share/texmf-var/tex/xelatex/common/etoolbox.sty && \
    texhash /usr/share/texmf-var

CMD [ "/bin/sh" ]

USER pandoc
WORKDIR /home/pandoc
