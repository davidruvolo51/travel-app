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
        # hero
        src$hero(
            id = "hero-finder",
            is_small = TRUE,
            tags$img(
                class = "illustration size-small airplane",
                src = "images/airplane-illustration.svg"
            ),
            tags$h1("Finder"),
            tags$h2("Get Travel Recommendations")
        ),

        # introduction section
        src$section(
            class = "section-finder-intro",
            tags$h2("Introduction"),
            tags$p(
                "This page can be used to get",
                "travel recommendations based on your preference for",
                "specialty coffee, craft breweries, and museums.",
                "Scroll through the following sections to learn more",
                "about the data and find a destination that fits your",
                "ideal holiday."
            )
        ),

        # first section: summary of the data
        src$section(
            class = "section-finder-summary",
            tags$figure(id = "data-summary",
                tags$figcaption("Summary of the data")
            )
        ),

    )
}