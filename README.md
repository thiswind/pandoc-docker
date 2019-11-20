# Pandoc Docker Image for use in Gitlab CI builds

Docker image for the source distribution of [Pandoc](http://johnmacfarlane.net/pandoc), with Latex tools installed. This image can be run interactively via the Docker CLI, but was designed to be used to automatically build PDF files from various file types (latex, rst, markdown, etc.)

## To use as an interactive Docker container

`cd` to the dir with your source files, then:

```bash
$ docker run -v $PWD:/build ntwrkguru/pandoc-gitlab-ci pandoc [OPTIONS] [FILES]
```
From `--help`

    pandoc [OPTIONS] [FILES]
    Input formats:  docbook, haddock, html, json, latex, markdown, markdown_github,
                    markdown_mmd, markdown_phpextra, markdown_strict, mediawiki,
                    native, opml, rst, textile
    Output formats: asciidoc, beamer, context, docbook, docx, dzslides, epub, epub3,
                    fb2, html, html5, json, latex, man, markdown, markdown_github,
                    markdown_mmd, markdown_phpextra, markdown_strict, mediawiki,
                    native, odt, opendocument, opml, org, pdf*, plain, revealjs,
                    rst, rtf, s5, slideous, slidy, texinfo, textile
                    [*for pdf output, use latex or beamer and -o FILENAME.pdf

A `/build` directory is created in the container, which can be mapped for use with relative file paths. Pandoc will always be run from the `/build` directory in the container.

## To use in .gitlab-ci.yml

The following example will build test.md from `./`

```yaml
image: thiswind/pandoc-docker

DOCX:
  script:
    - pandoc \
        -f markdown \
        -t docx \
        -o test.docx \
        test.md
  artifacts:
    paths:
      - "*.docx"
```

## to test gitlab-runner locally

```yaml
image: thiswind/pandoc-docker

DOCX:
  script:
    - pandoc \
        -f markdown \
        -t docx \
        -o test.docx \
        test.md
  artifacts:
    paths:
      - "*.docx"
  cache: &build_artifact_cache
    key: build
    paths:
      - "*.pdf"
```

then 

```bash
gitlab-runner exec docker --docker-volumes $(pwd)/cache:/cache DOCX
```

after all, your artifacts will be saved locally at `./cache/.../cache.zip`

REPO on DockerHub: [thiswind/pandoc-docker](https://hub.docker.com/r/thiswind/pandoc-docker)
