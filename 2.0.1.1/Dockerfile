FROM alpine:3.6

LABEL maintainer="peter.kurfer@gmail.com"

ENV PANDOC_VERSION="2.0.1.1"

ADD http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz /tmp
ADD https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux.tar.gz /tmp
COPY ./installation.profile /tmp/

RUN tar -xf /tmp/install-tl-unx.tar.gz -C /tmp/ && \
    apk add --no-cache --update perl wget xz && \
    rm -rf /var/cache/apk/* && \
    /tmp/install-tl-*/install-tl --profile=/tmp/installation.profile && \
    tar -xf /tmp/pandoc-${PANDOC_VERSION}-linux.tar.gz -C /tmp && \
    mv /tmp/pandoc-${PANDOC_VERSION}/bin/* /usr/bin/ && \
    rm -rf /tmp/*

ENTRYPOINT [ "/bin/sh" ]