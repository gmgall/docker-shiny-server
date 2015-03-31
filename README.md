Shiny Server Examples for Docker
================================

This is a Dockerfile for Shiny Server on Ubuntu Trusty. It serves only the examples apps provided with the Shiny Server package.

The image is available from [Docker Hub](https://registry.hub.docker.com/u/gmgall/shiny-server-examples/)

## Usage:

To run a container with Shiny Server in background (The container *will not* be removed after it exits. Do it manually.):

```sh
docker run -d -p 3838:3838 gmgall/shiny-server-examples
```

To run a container with Shiny Server that will be removed when it exits:

```sh
docker run --rm -p 3838:3838 gmgall/shiny-server-examples
```

Then access ``localhost:3838/sample-apps/`` from a browser to use one of the sample Shiny apps.

## Features

* Based on Ubuntu Trusty (14.04 LTS)
* Uses the R provided by the ``r-base`` package from the [Fiocruz](http://portal.fiocruz.br/pt-br) [CRAN repository](http://cran.fiocruz.br/)
* Uses the shiny and rmarkdown R packages from cran.rstudio.com
