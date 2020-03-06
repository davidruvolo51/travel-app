#' ////////////////////////////////////////////////////////////////////////////
#' FILE: ui.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-03-06
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
        tags$meta(charset = "utf-8"),
        tags$meta(`http-equiv` = "X-UA-Compatible", content = "IE=edge"),
        tags$meta(
            name = "viewport",
            content = "width=device-width, initial-scale=1"
        ),
        tags$script(
            src = "https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.js"
        ),
        tags$link(
            href = "https://api.mapbox.com/mapbox-gl-js/v1.8.1/mapbox-gl.css",
            rel = "stylesheet"
        ),
        tags$link(
            rel = "stylesheet",
            type = "text/css",
            href = "css/styles.css"
        ),
        tags$title("shinyTravel")
    ),
    #' Loading page -- will be removed post load
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
    #' App output container and subpages
    tags$div(id = "root",
        #' Navbar
        tags$nav(class = "nav", role = "navigation",
            tags$h1(
                class = "nav-item nav-title",
                "shinyTravel"
            ),
            #' Links
            tags$ul(
                id = "navlinks",
                class = "nav-item menu",
                tags$li(class = "menu-item",
                    tags$a(
                        id = "home",
                        class = "shiny-bound-input menu-link",
                        href = "home",
                        `data-tab` = "home",
                        "Home"
                    )
                ),
                tags$li(class = "menu-item",
                    tags$a(
                        id = "search",
                        class = "shiny-bound-input menu-link",
                        href = "search",
                        `data-tab` = "search",
                        "Search"
                    )
                ),
                tags$li(class = "menu-item",
                    tags$a(
                        id = "map",
                        class = "shiny-bound-input menu-link",
                        href = "map",
                        `data-tab` = "map",
                        "Map"
                    )
                ),
                tags$li(class = "menu-item",
                    tags$a(
                        id = "data",
                        class = "shiny-bound-input menu-link",
                        href = "data",
                        `data-tab` = "data",
                        "Data"
                    )
                )
            ),
            #' Menu Toggle
            tags$div(
                class = "nav-item menu-item menu-btn",
                tags$button(
                    id = "toggle",
                    class = "btn btn-icon action-button shiny-button-input",
                    `aria-describedby` = "toggle-label",
                    `aria-expanded` = "false",
                    tags$span(
                        id = "toggle-label",
                        class = "visually-hidden",
                        "open and close menu"
                    ),
                    tags$span(
                        class = "menu-icon",
                        `aria-hidden` = "true",
                        tags$span(class = "menu-bar"),
                        tags$span(class = "menu-bar"),
                        tags$span(class = "menu-bar")
                    )
                )
            )
        ),
        uiOutput("page"),
        tags$div(
            id = "footer-banner",
            `aria-hidden` = "true",
            style = "
                background-image: url('images/page-footer-grayscale.svg')
            "
        ),
        tags$footer(
            class = "footer",
            tags$div(
                class = "footer-content",
                tags$h2("shinyTravel"),
                tags$ul(class = "menu", id = "footer-nav",
                    tags$li(class = "menu-item",
                        tags$a(class = "menu-link",
                            href = "https://github.com/davidruvolo51/travel-app",
                            "Code"
                        )
                    ),
                    tags$li(class = "menu-item",
                        tags$a(class = "menu-link",
                            href = "https://github.com/davidruvolo51/travel-app-data",
                            "Data"
                        )
                    ),
                    tags$li(class = "menu-item",
                        tags$a(class = "menu-link",
                            href = "https://github.com/davidruvolo51/travel-app/wiki",
                            "Wiki"
                        )

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