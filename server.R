#' ////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-03-06
#' PURPOSE: server for application
#' STATUS: working; ongoing
#' PACKAGES: shiny; tidyverse
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    #' load components
    source("src/components/client.R", local = TRUE)

    #' define starting page
    current_page <- reactiveVal("home")
    #' current_page <- reactiveVal("search")
    #' current_page <- reactiveVal("map")
    #' current_page <- reactiveVal("data")

    #' load server
    source("server/routing.R", local = TRUE)
    source("server/pages/search.R", local = TRUE)
    source("server/pages/data.R", local = TRUE)
    source("server/pages/map.R", local = TRUE)
    source("server/utils/travel_finder.R", local = TRUE)
    source("server/handlers/index.R", local = TRUE)


    #' load src/pages
    source("src/pages/home.R", local = TRUE)
    source("src/pages/search.R", local = TRUE)
    source("src/pages/map.R", local = TRUE)
    source("src/pages/data.R", local = TRUE)

    #' render page
    output$page <- renderUI(home_page())
    #' output$page <- renderUI(search_page())
    #' output$page <- renderUI(map_page())
    #' output$page <- renderUI(data_page())

    #' Remove loading screen with app
    Sys.sleep(1)
    js$remove_elem(elem = "#loading")
}