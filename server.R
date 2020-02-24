#'////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-24
#' PURPOSE: server for application
#' STATUS: in.progress
#' PACKAGES: shiny
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

    #' Function that converts input values to
    #' user preferences arrays
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

    #'//////////////////////////////////////
    #' ~ i ~
    #' define routing
    #' current_page <- reactiveVal("home")
    #' output$page <- renderUI(home_tab())
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
    validated <- reactiveVal(FALSE)
    hasError <- reactiveVal(FALSE)

    #' Run Code for Data
    observeEvent(input$submitForm, {

        #' Reset Form only if there is an error
        if (isTRUE(hasError())) {
            js$add_css("#travel-form-error", "visually-hidden")
            js$add_css("#limit-results-error", "visually-hidden")
            js$set_element_attribute(
                "#travel-form-error",
                "aria-hidden",
                "true"
            )
            js$set_element_attribute(
                "#limit-results-error",
                "aria-hidden",
                "true"
            )
        }

        #' Get Limits Input
        limits <- input$limitResults
        if (class(limits) != "integer" | limits > 50 | limits < 0) {

            #' Update Reactive Values and Client
            hasError(TRUE)
            js$remove_css("#travel-form-error", "visually-hidden")
            js$remove_css("#limit-results-error", "visually-hidden")
            js$remove_element_attribute("#travel-form-error", "aria-hidden")
            js$remove_element_attribute("#limit-results-error", "aria-hidden")

            #' Send Error Messages
            js$inner_html(
                "#travel-form-error",
                "ERROR: There was a problem with the 'limit results' field"
            )
            js$inner_html(
                "#limit-results-error",
                "ERROR: Enter a number from 0 to 50"
            )
        } else {
            #' Update Reactive Values
            validated(TRUE)
            hasError(FALSE)
        }
        
        if (isTRUE(validated())) {

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

        }
    })
}