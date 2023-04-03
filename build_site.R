rm(list=ls())

library(utils)

# Building images directory
if(dir.exists("images")){
  unlink("images", recursive=TRUE)
}
dir.create("images")

download.file("https://github.com/john-harrold/ubiquity/raw/master/man/figures/logo.png",
              file.path("images", "ubiquity_hex.png"))
download.file("https://github.com/john-harrold/formods/raw/master/man/figures/logo.png",
              file.path("images", "formods_hex.png"))
download.file("https://github.com/john-harrold/ruminate/raw/main/man/figures/logo.png",
              file.path("images", "ruminate_hex.png"))


# Building rumiante demo
if(dir.exists("ruminate")){
  unlink("ruminate", recursive=TRUE)
}
dir.create("ruminate")
file.copy(system.file(package='ruminate', 'templates', 'ruminate.R'), '/srv/shiny-server/ruminate/App.R')
# This forces the deployed flag in the app 
nat.utils::touch(file.path("ruminate", "DEPLOYED"))

# Building formods demo
if(dir.exists("formods")){
  unlink("formods", recursive=TRUE)
}
dir.create("formods")
file.copy(system.file(package='formods', 'templates', 'FM_compact.R'), '/srv/shiny-server/formods/App.R')

