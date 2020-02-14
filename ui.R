#' ////////////////////////////////////////////////////////////////////////////
#' FILE: ui.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-14
#' PURPOSE: client side for application
#' STATUS: working; on.going
#' PACKAGES: NA
#' COMMENTS:
#'      In this file, define all <head> content and load any javascript assets.
#'      This application works by rendering the subpages into the uiOutput
#'      element "page". This is loaded dynamically in the server.
#' ////////////////////////////////////////////////////////////////////////////
ui <- tagList(
    tags$head(`lang` = "en",
        tags$meta(charset = "utf-8"),
        tags$meta(`http-equiv` = "X-UA-Compatible", content = "IE=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$link(
            rel = "stylesheet",
            type = "text/css",
            href = "css/styles.min.css"
        ),
        tags$title("shinyTravel")
    ),
    src$app(
        src$navbar(
            title = "shinyTravel",
            labels = routes$labels,
            links = routes$links
        ),
        uiOutput("page"),
        src$footer(
            tags$h2("shinyTravel"),
            src$nav$navlinks(
                id = "footer-nav",
                labels = c(
                    "Source",
                    "Data",
                    "Wiki"
                ),
                links = c(
                    "https://github.com/davidruvolo51/travel-app",
                    "https://github.com/davidruvolo51/travel-app-data",
                    "https://github.com/davidruvolo51/travel-app/wiki"
                    )
            )
        )
    ),
    tags$script(src = "js/index.js")
)