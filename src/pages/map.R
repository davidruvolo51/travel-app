#'////////////////////////////////////////////////////////////////////////////
#' FILE: map.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-03-03
#' PURPOSE: ui page component for explorer page
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: import page in server and use the reactiveVal "current_page" to
#'           dynamically render map page
#'////////////////////////////////////////////////////////////////////////////
map_page <- function() {
    tags$main(
        id = "map-main",
        class = "main main-extra-top-spacing",
        tags$header(
            id = "hero-map",
            class = "hero hero-small",
            tags$div(
                class = "hero-content",
                tags$h1("Map"),
                tags$h2("Find travel destinations using an interactive map")
            )
        )
    )
}