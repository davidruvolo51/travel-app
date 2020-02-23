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
    source("server/utils/viz.R")
    source("scripts/utils/travel_finder.R")

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
    })
    observeEvent(input$finder, {
        if (current_page() != "finder") {
            current_page("finder")
            output$page <- renderUI(finder_tab())
        }
    })
    observeEvent(input$appStart, {
        if (current_page() != "finder") {
            current_page("finder")
            output$page <- renderUI(finder_tab())
            js$scroll_to_top()
        }
    })
    observeEvent(input$explorer, {
        if (current_page() != "explorer") {
            current_page("explorer")
            output$page <- renderUI(explorer_tab())
            js$scroll_to_top()
        }
    })

    #' Switch Loading Screen with App
    js$remove_elem(elem = "#loading");

    #' Run Code for Data
    observeEvent(input$submitForm, {
        js$console_log("form submitted!")
        js$console_log(input$coffeePrefs)
        js$console_log(input$breweryPrefs)
        js$console_log(input$museumPrefs)

        setUserPreferences <- function(input) {
            case_when(
                input == "No Preference" ~ c(0, 0),
                input == "Not at all" ~ c(1, -1),
                input == "Somewhat" ~ c(1, 1),
                input == "Important" ~ c(1, 2),
                input == "Very" ~ c(1, 3),
                input == "Essential" ~ c(1, 4),
                TRUE ~ NA_real_
            )
        }

        #' Calculate Weights and Ratings Based on Selection
        coffee_pref <- setUserPreferences(input$coffeePrefs)
        brewery_pref <- setUserPreferences(input$breweryPrefs)
        museum_pref <- setUserPreferences(input$museumPrefs)

        #' Collate Preferences into weights and ratings objects
        weights <- c(coffee_pref[1], brewery_pref[1], museum_pref[1])
        ratings <- c(coffee_pref[2], brewery_pref[2], museum_pref[2])

        #' Run
        results <- travel_preferences(weights, ratings)
        js$console_log(results[1:3, ])
    })
}