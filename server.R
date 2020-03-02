#' ////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-03-02
#' PURPOSE: server for application
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    #' define starting page
    #' current_page <- reactiveVal("home")
    #' output$page <- renderUI(home_tab())
    current_page <- reactiveVal("search")
    output$page <- renderUI(search_page())
    #' current_page <- reactiveVal("data")
    #' output$page <- renderUI(data_page())

    #' load server
    source("server/routing.R", local = TRUE)
    source("server/pages/search.R", local = TRUE)
    source("server/pages/data.R", local = TRUE)
    source("server/pages/map.R", local = TRUE)
    source("server/utils/travel_finder.R", local = TRUE)
    source("server/handlers/index.R", local = TRUE)
    source("server/handlers/viz.R", local = TRUE)


    #' load src/pages
    source("src/pages/home.R", local = TRUE)
    source("src/pages/search.R", local = TRUE)
    source("src/pages/map.R", local = TRUE)
    source("src/pages/data.R", local = TRUE)

    #' Remove loading screen with app
    js$remove_elem(elem = "#loading")
}