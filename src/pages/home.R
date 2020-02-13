#'////////////////////////////////////////////////////////////////////////////
#' FILE: home.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-13
#' PURPOSE: ui component for home page
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
page <- function() {
    src$main(
        src$hero(id = "start",
            tags$h1("Shiny Travel"),
            tags$h2("Planning your next European City Break around Specialty Coffee and Craft Breweries")
        )
    )
}