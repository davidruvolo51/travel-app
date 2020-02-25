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
    tags$head(
        `lang` = "en",
        tags$meta(charset = "utf-8"),
        tags$meta(`http-equiv` = "X-UA-Compatible", content = "IE=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$link(
            rel = "stylesheet",
            type = "text/css",
            href = "css/styles.css"
        ),
        tags$title("shinyTravel")
    ),
    tags$div(id = "loading",
        tags$p(class = "visually-hidden", "Loading"),
        HTML("
            <svg aria-hidden='true' width='90' height='25' viewBox='0 0 90 25'>
                <circle class='dot' cx='10' cy='12.5' r='10' />
                <circle class='dot' cx='40' cy='12.5' r='10' />
                <circle class='dot' cx='70' cy='12.5' r='10' />
            </svg>"
        )
    ),
    tags$div(
        id = "root",
        src$app(
            src$navbar(
                title = "shinyTravel",
                links = c("home", "finder", "explorer", "data"),
                labels = c("Home", "Finder", "Explorer", "Data")
            ),
            uiOutput("page"),
            tags$div(
                class = "footer-banner",
                `aria-hidden` = "true",
                style = "
                    background-image: url('images/page-footer-grayscale.svg')
                "
            ),
            src$footer(
                tags$h2("shinyTravel"),
                src$nav$navlinks(
                    id = "footer-nav",
                    labels = c(
                        "Code",
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
        )
    ),
    #' Load Assets
    tags$script(src = "assets/d3.v5.min.js"),
    tags$script(src = "assets/topojson.min.js"),
    tags$script(src = "js/index.js")
)