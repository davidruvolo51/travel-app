#' ////////////////////////////////////////////////////////////////////////////
#' FILE: routing.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-24
#' MODIFIED: 2020-02-24
#' PURPOSE: application routing
#' STATUS: working
#' PACKAGES: shiny
#' COMMENTS: the following code handles all application routing and subpage
#' loads, as well as updating aria attributes
#' ////////////////////////////////////////////////////////////////////////////
routing <- function(input, output, session, current_page) {
    
    #' Load pages
    source("src/pages/home.R")
    source("src/pages/finder.R")
    source("src/pages/explorer.R")

    #' Switch to Home Page
    observeEvent(input$home, {
        if (current_page() != "home") {
            js$set_element_attribute(
                paste0("#", current_page()),
                "aria-current",
                "page"
            )
            js$set_element_attribute("#home", "aria-current", "page")
            current_page("home")
            output$page <- renderUI(home_tab())
            js$scroll_to_top()
        }
    })

    #' Switch to Finder Page
    observeEvent(input$finder, {
        if (current_page() != "finder") {
            js$set_element_attribute(
                paste0("#", current_page()),
                "aria-current",
                "page"
            )
            js$set_element_attribute("#finder", "aria-current", "page")
            current_page("finder")
            output$page <- renderUI(finder_tab())
            js$scroll_to_top()
        }
    })
    
    #' Switch to Finder Page
    observeEvent(input$appStart, {
        if (current_page() != "finder") {
            js$set_element_attribute(
                paste0("#", current_page()),
                "aria-current",
                "page"
            )
            js$set_element_attribute("#finder", "aria-current", "page")
            current_page("finder")
            output$page <- renderUI(finder_tab())
            js$scroll_to_top()
        }
    })

    #' Switch to Explorer Page
    observeEvent(input$explorer, {
        if (current_page() != "explorer") {
            js$set_element_attribute(
                paste0("#", current_page()),
                "aria-current",
                "page"
            )
            js$set_element_attribute("#explorer", "aria-current", "page")
            current_page("explorer")
            output$page <- renderUI(explorer_tab())
            js$scroll_to_top()
        }
    })
}