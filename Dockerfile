FROM rocker/shiny-verse:4.2.0

## Install R libraries
RUN R -e "install.packages('remotes',      repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rstudioapi',   repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('gridExtra',    repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('nat.utils',    repos='http://cran.rstudio.com/')"

# Installing the development versions of packages
RUN R -e "remotes::install_github('billdenney/pknca',      dependencies=TRUE)"
RUN R -e "remotes::install_github('john-harrold/onbrand',  dependencies=TRUE)"
RUN R -e "remotes::install_github('john-harrold/formods',  dependencies=TRUE)"
RUN R -e "remotes::install_github('john-harrold/ruminate', dependencies=TRUE)"
RUN R -e "remotes::install_github('john-harrold/ubiquity', dependencies=TRUE)"

# Clearing out the shiny server default files:
RUN rm -rf srv/shiny-server/*


# Pulling down the repo with the required files:
WORKDIR /srv/shiny-server
RUN wget https://github.com/john-harrold/shiny_demo_dev/archive/refs/heads/main.zip
RUN unzip main.zip
RUN mv shiny_demo_dev-main/mab_pk .
RUN mv shiny_demo_dev-main/build_site.R .

# Building the site
RUN R -e 'source("build_site.R")'

# Deploying ubiquity models:
WORKDIR mab_pk
RUN R -e 'source("ubiquity_app.R")'
WORKDIR ..

# Cleaning up unnecessary files
RUN rm -rf shiny_demo_dev-main
RUN rm -rf main.zip
RUN rm -rf build_site.R

# RUN mkdir 'srv/shiny-server/ruminate'
# RUN R -e "file.copy(system.file(package='ruminate', 'templates', 'ruminate.R'), '/srv/shiny-server/ruminate/App.R')"
# 
# RUN mkdir 'srv/shiny-server/formods'
# RUN R -e "file.copy(system.file(package='formods', 'templates', 'FM_compact.R'), '/srv/shiny-server/formods/App.R')"

## Open the port for Shiny
EXPOSE 3838

