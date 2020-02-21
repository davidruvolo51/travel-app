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
        class = "main-extra-top-spacing",
        src$hero(
            id = "hero-data",
            is_small = TRUE,
            tags$h1("Data"),
            tags$h2("View all data in the database")
        ),
        src$section(
            id = "data-intro",
            class = "section-data-intro",
            tags$h2("About"),
            tags$p(
                "On this page, you can view the summarized data for all",
                "cities. Use the filters below to refine your search. The",
                "complete dataset, can be found on the GitHub data repository."
            )
        )
    )
}