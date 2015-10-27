FROM ubuntu:trusty

MAINTAINER Guilherme Gall <gmgall@gmail.com>

# Fetching the key that signs the CRAN packages
# Reference: http://cran.rstudio.com/bin/linux/ubuntu/README.html
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Fetching the key that signs the Webupd8 Oracle Java packages
# Reference: http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# Adding Fiocruz repository
RUN /bin/echo -e '\n## Fiocruz CRAN repository\ndeb http://cran.fiocruz.br/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list

# Adding Webupd8 repository
RUN /bin/echo -e 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main\ndeb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list.d/webupd8team-java.list

# Accepting Java license
RUN /bin/echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

RUN apt-get update && apt-get install -y \
    r-base \
    wget \
    gdebi-core \
    subversion \
    libgdal-dev \
    libproj-dev \
    language-pack-pt-base \
    libcurl4-gnutls-dev \
    oracle-java8-installer \
    libv8-dev

# XXX Why javareconf needs to be used 2 times?
RUN R CMD javareconf

# Install R packages
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('rmarkdown', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('rjson', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('maps', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('raster', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('dismo', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('shinythemes', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('rgdal', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('devtools', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('rgbif', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('randomForest', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('kernlab', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('rJava', repos='http://cran.rstudio.com/')" && \
    R -e "options(repos='http://cran.rstudio.com/'); devtools::install_github('rstudio/leaflet')"

# Configuring R to use installed Oracle Java
RUN R CMD javareconf

# Download and install Shiny Server
WORKDIR /tmp/
RUN wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.3.0.403-amd64.deb && \
    gdebi -n shiny-server-1.3.0.403-amd64.deb && \
    rm shiny-server-1.3.0.403-amd64.deb

EXPOSE 3838

ENV LANG pt_BR.UTF-8

# shiny user is created by the Shiny Server package installed above
USER shiny

CMD ["shiny-server"]
