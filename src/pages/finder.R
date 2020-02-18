#'////////////////////////////////////////////////////////////////////////////
#' FILE: finder.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-18
#' PURPOSE: ui page component for finder tab
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
finder_tab <- function() {
    src$main(
        src$hero(
            id = "hero-finder",
            tags$h1("Finder"),
            tags$h2("Get Travel Recommendations")
        )
    )
}