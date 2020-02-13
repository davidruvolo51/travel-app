#'//////////////////////////////////////////////////////////////////////////////
#' FILE: data_0_source.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-12
#' MODIFIED: 2020-02-12
#' PURPOSE: download data from git repo travel-app-data
#' STATUS: working; complete
#' PACKAGES: NA (uses bash)
#' COMMENTS:
#'      This script pulls the following datasets from the GitHub repository:
#'      travel-app-data/
#'          + data/
#'              - breweries_all_cities.RDS
#'              - coffee_all_cities.RDS
#'
#'      Then run the subsequent scripts to prep the data for use in the viz
#'//////////////////////////////////////////////////////////////////////////////

#' ~ 1 ~
#' Download Datasets

#' build new cmd for breweries dataset
cmd_a <- paste0(
    "curl -O ",
    "https://raw.githubusercontent.com/davidruvolo51/",
    "travel-app-data/master/data/",
    "breweries_all_cities.RDS"
)

#' build new cmd for coffee dataset
cmd_b <- paste0(
    "curl -O ",
    "https://raw.githubusercontent.com/davidruvolo51/",
    "travel-app-data/master/data/",
    "coffee_all_cafes.RDS"
)

#' run both cmds
system(cmd_a)
system(cmd_b)


#' mv files to data/
system("mv *.RDS data/downloads")