#'////////////////////////////////////////////////////////////////////////////
#' FILE: data.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-25
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
            tags$im(
                class = "illustration size-small ticket",
                src = "images/ticket-illustration.svg"
            ),
            tags$h1("Data"),
            tags$h2("View the Data")
        ),
        src$section(
            id = "data-intro",
            class = "section-data-intro",
            tags$h2("About"),
            tags$p(
                "On this page, you can view all of the summarized datasets",
                "used in the app. The data is sourced from multiple sources.",
                "All data is based on cities where there is a specialty",
                "coffee scene as listed on",
                tags$a(
                    href = "https://europeancoffeetrip.com",
                    "European Coffee Trip"
                ),
                ". Using the city guides as a reference point,",
                tags$a(
                    href = "http://overpass-api.de",
                    "Overpass API"
                ),
                "queries were run to find museums and data located in each",
                "city. The data was merged and summarized to create a",
                "dataset for generating user preferences and recommendations.",
                "The source code and data files can be found in the",
                tags$a(
                    href = "https://github.com/davidruvolo51/travel-app-data",
                    "data repository"
                ), ".",
            )
        ),
        src$section(
            id = "summary-of-data",
            tags$h2("Summary of Data")
        )
    )
}