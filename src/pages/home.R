#' ////////////////////////////////////////////////////////////////////////////
#' FILE: home.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-03-03
#' PURPOSE: ui component for home page
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
home_page <- function() {
    shiny_btn_css <- "action-button shiny-bound-input"
    tags$main(
        id = "home-main",
        class = "main main-extra-top-spacing",
        tags$header(
            id = "hero-home",
            class = "hero",
            tags$div(class = "hero-content",
                tags$img(
                    class = "illustration size-lg",
                    src = "images/shiny-travel-illustration.svg"
                ),
                tags$h1("shinyTravel"),
                tags$h2("Plan your next European holiday using data")
            )
        ),
        tags$section(
            id = "section-about",
            class = "section flex flex-50x2-layout",
            tags$div(
                class = "flex-child child-centered",
                tags$img(
                    class = "illustration size-small airplane",
                    src = "images/airplane-illustration.svg"
                )
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
                    "European holiday. This app provides city recommendations",
                    "based on", tags$strong("your"), "preference for",
                    "specialty coffee, craft breweries, and museums",
                )
            )
        ),
        tags$section(
            id = "section-howto",
            class = "section flex flex-50x2-layout flex-wrap-reverse",
            tags$div(
                class = "flex-child",
                tags$h2(
                    "How do I use",
                    tags$span(class = "app-title", "shinyTravel"),
                    "?"
                ),
                tags$p(
                    "You can use the",
                    tags$span(class = "app-title", "shinyTravel"),
                    "app in a number of ways. Use the",
                    tags$strong("Finder"), "to get city recommendations.",
                    "You can also use the", tags$strong("Explorer"), "page",
                    "to search for cities and places to visit."
                )
            ),
            tags$div(
                class = "flex-child child-centered",
                tags$img(
                    class = "illustration size-small camera",
                    src = "images/camera-illustration.svg"
                )
            )
        ),
        tags$section(
            id = "section-learn",
            class = "section flex flex-50x2-layout",
            tags$div(
                class = "flex-child child-centered",
                tags$img(
                    class = "illustration size-small ticket",
                    src = "images/ticket-illustration.svg"
                )
            ),
            tags$div(
                class = "flex-child",
                tags$h2("Where can I read more about the app?"),
                tags$p(
                    "All of the",
                    tags$a(
                        href = "https://github.com/davidruvolo51/travel-app",
                        "code"
                    ),
                    "and",
                    tags$a(
                        href =
                            "https://github.com/davidruvolo51/travel-app-data",
                        "data"
                    ),
                    "is available on github. See the",
                    tags$a(
                        href =
                            "https://github.com/davidruvolo51/travel-app/wiki",
                        "Wiki"
                    ),
                    "for more information about the development of the app,",
                    "methods, and data. If you have any questions, feel free",
                    "to open a new",
                    tags$a(
                        href = "https://github.com/davidruvolo51/travel-app/issue",
                        "issue"
                    ), "."
                )
            )
        ),
        tags$section(
            id = "section-start",
            class = "section",
            tags$h2("Are you reading to start planning your holiday?"),
            tags$p("Let's get started. Click the button below."),
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