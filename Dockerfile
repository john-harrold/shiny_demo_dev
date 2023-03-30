FROM rocker/shiny-verse:4.2.0

## Install R libraries
RUN R -e "install.packages('remotes',      repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('rstudioapi',   repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('gridExtra',    repos='http://cran.rstudio.com/')"

# Installing the development versions of packages
RUN R -e "remotes::install_github('john-harrold/onbrand',  dependencies=TRUE)"
RUN R -e "remotes::install_github('john-harrold/formods',  dependencies=TRUE)"
RUN R -e "remotes::install_github('john-harrold/ruminate', dependencies=TRUE)"
RUN R -e "remotes::install_github('john-harrold/ubiquity', dependencies=TRUE)"

# Clearing out the shiny server default files:
RUN rm -rf srv/shiny-server/*


# RUN mkdir 'srv/shiny-server/ruminate'
# RUN R -e "file.copy(system.file(package='ruminate', 'templates', 'ruminate.R'), '/srv/shiny-server/ruminate/App.R')"
# 
# RUN mkdir 'srv/shiny-server/formods'
# RUN R -e "file.copy(system.file(package='formods', 'templates', 'FM_compact.R'), '/srv/shiny-server/formods/App.R')"

## Open the port for Shiny
EXPOSE 3838

