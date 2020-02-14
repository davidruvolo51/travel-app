#' ////////////////////////////////////////////////////////////////////////////
#' FILE: home.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-14
#' PURPOSE: ui component for home page
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
page <- function() {
    shiny_btn_css <- "action-button shiny-bound-input"
    src$main(
        src$hero(id = "home",
            tags$h1("shinyTravel"),
            tags$h2("Plan your next European city break using data")
        ),
        src$section(
            id = "about", class = "flex flex-50x2-layout",
            tags$div(
                class = "flex-child",
                tags$p("Some image will go here")
            ),
            tags$div(
                class = "flex-child",
                tags$h2(
                    "What is",
                    tags$span(class = "app-title", "shinyTravel"),
                    "?"
                ),
                tags$p(
                    tags$span(class = "app-title", "shinyTravel"),
                    "is a data-driven shiny app for planning your next",
                    "European holiday. This app focuses on your preference",
                    "for specialty coffee, craft breweries, and museums to",
                    "provide recommendations on the ideal destination."
                )
            )
        ),
        src$section(
            id = "start", class = "start",
            tags$h2(
                "How do I use",
                tags$span(class = "app-title", "shinyTravel"),
                "?"
            ),
            tags$p("Are you reading to start planning your holiday?"),
            tags$p(
                "Use the", tags$span(class = "page-title", "Finder"),
                "to get recommendations or use the",
                tags$span(class = "page-title", "Explorer"),
                "to view all locations."
            ),
            tags$ul(
                class = "b-list", `aria-describedby` = "b-list-title",
                tags$span(
                    id = "b-list-title",
                    class = "visually-hidden",
                    "Choose a data visualization module"
                ),
                tags$li(
                    class = "b-list-item",
                    tags$button(
                        class = paste0(
                            shiny_btn_css,
                            " b b-secondary"
                        ),
                        "Explorer"
                    )
                ),
                tags$li(
                    class = "b-list-item",
                    tags$button(
                        class = paste0(
                            shiny_btn_css,
                            " b b-primary"
                        ),
                        "Finder"
                    )
                )
            )
        )
    )
}