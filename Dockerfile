FROM haskell:8

MAINTAINER Stephen Steiner <ntwrkguru@gmail.com>

# Install cabal and then pandoc + citeproc
RUN stack install pandoc pandoc-citeproc

WORKDIR /build
