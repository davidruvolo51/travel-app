#'////////////////////////////////////////////////////////////////////////////
#' FILE: explorer.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-18
#' PURPOSE: ui page component for explorer page
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NAS
#'////////////////////////////////////////////////////////////////////////////
explorer_tab <- function() {
    src$main(
        src$hero(
            id = "hero-explorer",
            tags$h1("Explorer"),
            tags$h2("Find travel destinations using an interactive map")
        )
    )
}