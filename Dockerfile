FROM rocker/tidyverse:latest 

RUN mkdir -p $HOME/.R

RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    liblzma-dev \
    libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
    && R CMD javareconf \
    && install2.r --error \
        ggstance ggrepel ggthemes \
        ###My packages are below this line
        tidytext janitor corrr officer devtools pacman \
        tidyquant timetk tibbletime sweep broom prophet \
        forecast prophet lime sparklyr h2o rsparkling unbalanced \
        formattable httr rvest xml2 jsonlite \
        textclean naniar writexl \
    && Rscript -e 'devtools::install_github(c("hadley/multidplyr","jeremystan/tidyjson","ropenscilabs/skimr"))' \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
 && rm -rf /var/lib/apt/lists/*
