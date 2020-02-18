#'////////////////////////////////////////////////////////////////////////////
#' FILE: data.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-18
#' PURPOSE: ui page component for data tab
#' STATUS: in.progress
#' PACKAGES: shiny; see global
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
data_tab <- function() {
    src$main(
        src$hero(
            id = "hero-data",
            tags$h1("Data"),
            tags$h2("View all data in the database")
        )
    )
}