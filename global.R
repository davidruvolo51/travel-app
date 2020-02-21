#'////////////////////////////////////////////////////////////////////////////
#' FILE: global.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-18
#' PURPOSE: global script for app
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

#' pkgs
suppressPackageStartupMessages(library(shiny))

#' load components
source("src/components/client.R")

#' Define application routes
routes <- list(
    links = c("home","finder", "explorer"),
    labels = c("Home","Finder", "Explorer")
)