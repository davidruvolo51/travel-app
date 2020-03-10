#' ////////////////////////////////////////////////////////////////////////////
#' FILE: home.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-03-10
#' PURPOSE: ui component for home page
#' STATUS: working
#' PACKAGES: see global
#' COMMENTS: Requires some functional components and illustrations
#' ////////////////////////////////////////////////////////////////////////////
home_page <- function() {
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
                tags$h2("Plan Your Next European Holiday Using Data")
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
                    "based on your preference for breweries, museums, and",
                    "cafes with specialty coffee.",
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
                    tags$strong("Search"), "page to get city recommendations",
                    "and the", tags$strong("Map"), "page to explore all ",
                    "locations. On the ", tags$strong("Data"), "page,",
                    "you can view a list of locations by type and city."
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
                    "The",
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
                    "used to develop this app are available on GitHub. See the",
                    "accompanying",
                    tags$a(
                        href = "https://davidruvolo51.github.io/shinytutorials/tutorials/shiny-contest-submission",
                        "blog post"
                    ),
                    "for more information."
                )
            )
        ),
        tags$section(
            id = "section-start",
            class = "section",
            tags$h2("Are you ready to start planning your holiday?"),
            tags$p("Let's get started! Click the button below."),
            tags$button(
                id = "appStart",
                class = "action-button shiny-bound-input b b-primary",
                "Start"
            )
        )
    )
}