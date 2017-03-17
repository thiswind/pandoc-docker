FROM haskell:8

MAINTAINER Stephen Steiner <ssteiner@juniper.net>

# Install dependencies
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
       texlive-latex-base \
       texlive-xetex latex-xcolor \
       texlive-math-extra \
       texlive-latex-extra \
       texlive-fonts-extra \
       texlive-bibtex-extra \
       fontconfig \
       lmodern \
       libghc-text-icu-dev \
    && apt-get clean \
    && cabal update && cabal install pandoc pandoc-citeproc

WORKDIR /build
