FROM ubuntu:trusty

MAINTAINER Stephen Steiner <ssteiner@juniper.net>

# Install dependencies
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
       apt-utils \
       haskell-platform \
       texlive-latex-base \
       texlive-xetex latex-xcolor \
       texlive-math-extra \
       texlive-latex-extra \
       texlive-fonts-extra \
       texlive-bibtex-extra \
       fontconfig \
       lmodern \
       libghc-text-icu-dev \
    && apt-get clean

# Install cabal and then pandoc + citeproc
RUN cabal update && cabal install pandoc pandoc-citeproc --force-reinstalls

WORKDIR /build
