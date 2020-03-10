#' ////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-03-10
#' PURPOSE: server for application
#' STATUS: working; ongoing
#' PACKAGES: see global
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    #' load components
    source("src/components/client.R", local = TRUE)

    #' define starting page
    current_page <- shiny::reactiveVal("home")

    #' load server
    source("server/routing.R", local = TRUE)
    source("server/pages/search.R", local = TRUE)
    source("server/pages/data.R", local = TRUE)
    source("server/utils/travel_finder.R", local = TRUE)
    source("server/handlers/index.R", local = TRUE)

    #' load src/pages
    source("src/pages/home.R", local = TRUE)
    source("src/pages/search.R", local = TRUE)
    source("src/pages/map.R", local = TRUE)
    source("src/pages/data.R", local = TRUE)

    #' render page
    output$page <- shiny::renderUI(home_page())

    #' Remove loading screen with app
    Sys.sleep(1)
    js$remove_elem(elem = "#loading")
}