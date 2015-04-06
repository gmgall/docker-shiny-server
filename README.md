Shiny Server for Docker
=======================

This is a Dockerfile for Shiny Server on Ubuntu Trusty. Some R packages needed by researchers of [Rio de Janeiro Botanical Garden](http://www.jbrj.gov.br/) are installed.

The image is available in [Docker Hub](https://registry.hub.docker.com/u/gmgall/shiny-server/)

## Usage

### Serving the sample apps that comes with Shiny Server

To run a container with Shiny Server in background (The container *will not* be removed after it exits. Do it manually.):

```sh
docker run -d -p 3838:3838 gmgall/shiny-server
```

To run a container with Shiny Server that will be removed when it exits:

```sh
docker run --rm -p 3838:3838 gmgall/shiny-server
```

Then access ``localhost:3838/sample-apps/`` from a browser to use one of the sample Shiny apps.

### Serving an arbitrary Shiny app 

To run an arbitrary Shiny app that are in a directory in the host, bind the host directory that contains the app with the ``/srv/shiny-server/`` directory in the container:

```sh
docker run -p 3838:3838 -v ~/Downloads/model/:/srv/shiny-server/ --rm gmgall/shiny-server
```

In the example above the Shiny app in host directory ``~/Downloads/model/`` will be served by the container through 3838 port.

If you need to monitor the app log file, bind the host directory that you want to receive the log with the ``/var/log/shiny-server/`` directory in the container:

```sh
docker run -p 3838:3838 -v ~/Downloads/model/:/srv/shiny-server/ -v /tmp/logs/:/var/log/shiny-server/  --rm gmgall/shiny-server
```

In the example above the app log will be written in the ``/tmp/logs`` host directory.

The owner of the file will be the ``shiny`` user (UID 999).

## Features

* Based on Ubuntu Trusty (14.04 LTS)
* Uses the R provided by the ``r-base`` package from the [Fiocruz](http://portal.fiocruz.br/pt-br) [CRAN repository](http://cran.fiocruz.br/)
* Installs the following R packages from http://cran.rstudio.com:
  - shiny
  - rmarkdown
  - rjson
  - maps
  - raster
  - dismo
  - shinythemes
  - rgdal
