#'////////////////////////////////////////////////////////////////////////////
#' FILE: map.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-27
#' PURPOSE: ui page component for explorer page
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: import page in server and use the reactiveVal "current_page" to
#'           dynamically render map page
#'////////////////////////////////////////////////////////////////////////////
map_page <- function() {
    src$main(
        src$hero(
            id = "hero-map",
            tags$h1("Map"),
            tags$h2("Find travel destinations using an interactive map")
        )
    )
}