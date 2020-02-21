#'////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-20
#' PURPOSE: server for application
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    # load ui pages
    source("src/pages/home.R", local = TRUE)
    source("src/pages/finder.R", local = TRUE)
    source("src/pages/explorer.R", local = TRUE)

    #' load utils and modules
    source("server/utils/handlers.R")

    #' define server variables
    # current_page <- reactiveVal("home")
    # output$page <- renderUI(home_tab())
    current_page <- reactiveVal("finder")
    output$page <- renderUI(finder_tab())

    observeEvent(input$home, {
        if (current_page() != "home") {
            current_page("home")
            output$page <- renderUI(home_tab())
            js$scroll_to_top()
        }
    }, ignoreInit = TRUE)
    observeEvent(input$finder, {
        if (current_page() != "finder") {
            current_page("finder")
            output$page <- renderUI(finder_tab())
            js$scroll_to_top()
        }
    }, ignoreInit = TRUE)
    observeEvent(input$appStart, {
        if (current_page() != "finder") {
            current_page("finder")
            output$page <- renderUI(finder_tab())
            js$scroll_to_top()
        }
    }, ignoreInit = TRUE)
    observeEvent(input$explorer, {
        if (current_page() != "explorer") {
            current_page("explorer")
            output$page <- renderUI(explorer_tab())
            js$scroll_to_top()
        }
    }, ignoreInit = TRUE)

    #' Switch Loading Screen with App
    # Sys.sleep(2)
    js$remove_elem(elem = "#loading");
}