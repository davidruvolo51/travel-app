#' ////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-25
#' PURPOSE: server for application
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    #' load utils and ui
    source("src/pages/home.R")
    source("src/pages/finder.R")
    source("src/pages/explorer.R")
    source("src/pages/data.R")
    source("server/handlers.R")
    source("server/viz.R")
    source("scripts/utils/travel_finder.R")

    #' Function that converts input values to
    #' user preferences arrays
    setUserPreferences <- function(input) {
        case_when(
            input == "No Preference" ~ c(0, 0),
            input == "Not at all" ~ c(1, -2),
            input == "Tend to avoid" ~ c(1, -1),
            input == "Important" ~ c(1, 1),
            input == "Very" ~ c(1, 2),
            input == "Essential" ~ c(1, 3),
            TRUE ~ NA_real_
        )
    }

    #' //////////////////////////////////////
    #' ~ i ~
    #' define routing
    current_page <- reactiveVal("home")
    output$page <- renderUI(home_tab())
    #' current_page <- reactiveVal("finder")
    #' output$page <- renderUI(finder_tab())
    #' current_page <- reactiveVal("data")
    #' output$page <- renderUI(data_tab())

    #' Switch to Home Page
    observeEvent(input$home, {
        if (current_page() != "home") {
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
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
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
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
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
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
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
            )
            js$set_element_attribute("#explorer", "aria-current", "page")
            current_page("explorer")
            output$page <- renderUI(explorer_tab())
            js$scroll_to_top()
        }
    })

    #' Swicth to Data Page
    observeEvent(input$data, {
        if (current_page() != "data") {

            # Update Routing
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
            )
            js$set_element_attribute("#data", "aria-current", "page")
            current_page("data")
            output$page <- renderUI(data_tab())
            js$scroll_to_top()

            #' Write Totals to Text
            js$inner_html(
                "#summary-total-cities",
                travel$highlights$cities,
                delay = 250
            )
            js$inner_html(
                "#summary-total-countries",
                travel$highlights$countries,
                delay = 250
            )

            #' Render Table removing cities and countries count
            viz$render_datatable(
                id = "#summary-of-data",
                data = travel$highlights$all[-c(1, 2), ],
                columns = names(travel$highlights$all),
                caption = "Count of Places by Type",
                class = "datatable-small"
            )

            #' Render Summary of Countries
            country_summary <- travel$descriptives$places_by_country %>%
                select(
                    country,
                    place = type, n, n_country = places_country,
                    rate_country, rate_type
                ) %>%
                mutate(
                    "Country %" = paste0(
                        format(round(rate_country * 100, 1), nsmall = 1),
                        "%"
                    ),
                    "Place %" = paste0(
                        format(round(rate_type * 100, 1), nsmall = 1),
                        "%"
                    )
                ) %>%
                select(-rate_country, -rate_type) %>%
                as.data.frame()

            viz$render_datatable(
                id = "#summary-of-countries",
                data = country_summary,
                columns = names(country_summary),
                caption = "Count of Places by Type and Country"
            )
        }
    })

    #' Switch Loading Screen with App
    js$remove_elem(elem = "#loading")

    #' /////////////////////////////////////////////////////////////////////////

    #' Server Code for Finder Tab
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
                hasError(FALSE)

                #' Calculate Weights and Ratings Based on Selection
                coffee_pref <- setUserPreferences(input$coffeePrefs)
                brewery_pref <- setUserPreferences(input$breweryPrefs)
                museum_pref <- setUserPreferences(input$museumPrefs)

                #' Collate Preferences into weights and ratings objects
                weights <- c(coffee_pref[1], brewery_pref[1], museum_pref[1])
                ratings <- c(coffee_pref[2], brewery_pref[2], museum_pref[2])

                #' Run
                results <- travel_preferences(weights, ratings, limits)
                map_data <- results[c(1, 2, 3), ]
                viz$render_top_city_maps(map_data)
            }
        })
}