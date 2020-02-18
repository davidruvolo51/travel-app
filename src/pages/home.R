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
home_tab <- function() {
    shiny_btn_css <- "action-button shiny-bound-input"
    src$main(
        src$hero(id = "hero-home",
            tags$h1("shinyTravel"),
            tags$h2("Plan your next European city break using data")
        ),
        src$section(
            id = "section-about", class = "flex flex-50x2-layout",
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
            id = "section-howto", class = "flex flex-50x2-layout",
            tags$div(
                class = "flex-child",
                tags$h2(
                    "How do I use the",
                    tags$span(class = "app-title", "shinyTravel"),
                    "app?"
                ),
                tags$p(
                    "You can use the",
                    tags$span(class = "app-title", "shinyTravel"),
                    "app in a number of ways. Use the",
                    tags$strong("Finder"), "to get city recommendations",
                    "based on your preferences for coffee, breweries,",
                    "and museums. You can also search for places using",
                    "the interactive map. This is available in the",
                    tags$strong("Explorer"), "page. If you would like to view",
                    "all places, you can search through the data in the",
                    tags$strong("Data"), "page."
                )
            ),
            tags$div(
                class = "flex-child",
                tags$p("Some image will go here")
            )
        ),
        src$section(
            id = "section-start", class = "start",
            tags$h2("Are you reading to start planning your holiday?"),
            tags$p(
                "If you are ready to begin, navigate to any of the",
                "available pages or click the start button below."
            ),
            tags$button(
                id = "appStart",
                class = paste0(
                    shiny_btn_css,
                    " b b-primary"
                ),
                "Start"
            )
        )
    )
}