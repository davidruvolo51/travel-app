#'////////////////////////////////////////////////////////////////////////////
#' FILE: global.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-21
#' PURPOSE: global script for app
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

#' pkgs
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(tidyverse))

#' load components
source("src/components/client.R")

#' data
recs <- readRDS("data/travel_recommendations.RDS")
travel <- readRDS("data/travel_summary.RDS")