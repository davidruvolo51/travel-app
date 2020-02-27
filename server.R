#' ////////////////////////////////////////////////////////////////////////////
#' FILE: server.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-27
#' PURPOSE: server for application
#' STATUS: in.progress
#' PACKAGES: shiny
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
server <- function(input, output, session) {

    #' load utils and ui
    source("src/pages/home.R")
    source("src/pages/search.R")
    source("src/pages/map.R")
    source("src/pages/data.R")
    source("server/handlers.R")
    source("server/viz.R")
    source("server/travel_finder.R")

    #' Switch Loading Screen with App
    js$remove_elem(elem = "#loading")

    #' //////////////////////////////////////

    #' define routing
    # current_page <- reactiveVal("home")
    # output$page <- renderUI(home_tab())
    # current_page <- reactiveVal("search")
    # output$page <- renderUI(search_page())
    current_page <- reactiveVal("data")
    output$page <- renderUI(data_page())

    #' Switch to Home Page
    observeEvent(input$home, {
        if (current_page() != "home") {
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
            )
            js$set_element_attribute("#home", "aria-current", "page")
            current_page("home")
            output$page <- renderUI(home_page())
            js$scroll_to_top()
        }
    })

    #' Switch to Finder Page
    observeEvent(input$search, {
        if (current_page() != "search") {
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
            )
            js$set_element_attribute("#search", "aria-current", "page")
            current_page("search")
            output$page <- renderUI(search_page())
            js$scroll_to_top()
        }
    })

    #' Switch to Finder Page
    observeEvent(input$appStart, {
        js$remove_element_attribute(
            paste0("#", current_page()),
            "aria-current"
        )
        js$set_element_attribute("#search", "aria-current", "page")
        current_page("search")
        output$page <- renderUI(search_page())
        js$scroll_to_top()
    })

    #' Switch to Explorer Page
    observeEvent(input$map, {
        if (current_page() != "map") {
            js$remove_element_attribute(
                paste0("#", current_page()),
                "aria-current"
            )
            js$set_element_attribute("#map", "aria-current", "page")
            current_page("map")
            output$page <- renderUI(map_page())
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
            output$page <- renderUI(data_page())
            js$scroll_to_top()
        }
    })

    #' /////////////////////////////////////////////////////////////////////////

    #' Server Code for Finder Tab
    validated <- reactiveVal(FALSE)
    hasError <- reactiveVal(FALSE)
    reportVisible <- reactiveVal(FALSE)
    cityLimits <- reactiveVal(0)
    countryFilter <- reactiveVal(FALSE)

    #' Run Code for Data
    observeEvent(input$submitTravelForm, {

        #' Set ReactiveVals
        cityLimits(input$option_city_limits)
        countryFilter(input$countryFilter)

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
        if (class(cityLimits()) != "integer" | cityLimits() > 50 | cityLimits() < 0) {

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

            #' Reset Reactive Val for error
            hasError(FALSE)

            #' Reveal report on the first time only
            if (isFALSE(reportVisible())) {
                js$remove_css("#travel-summary", "visually-hidden")
                reportVisible(TRUE)
            }

            #' Prep weights
            w <- c(
                as.numeric(input$breweryPrefs),
                as.numeric(input$coffeePrefs),
                as.numeric(input$museumPrefs)
            )

            #' Define recs object base on user selections
            recs_filtered <- reactive({

                #' Assign Recs to tmp object
                recs_with_opts <- recs

                #' Apply Countries
                if (length(countryFilter()) > 0) {
                    recs_with_opts <- recs_with_opts %>%
                        filter(country %in% countryFilter())
                }

                #' Apply Limits
                if (cityLimits() > 0 & cityLimits() <= NROW(recs_with_opts)) {
                    recs_with_opts <- recs_with_opts %>%
                        arrange(-tot_n) %>%
                        slice((cityLimits() + 1):NROW(.)) %>%
                        as.data.frame(.)
                }

                #' Send logical flag if limits is greater than NROWS
                if (cityLimits() > NROW(recs_with_opts) | NROW(recs_with_opts) == 0) {
                    recs_with_opts <- FALSE
                }

                #' Return
                return(recs_with_opts)
            })

            #' Render Charts Based on Filtered Status
            if (recs_filtered() == FALSE) {
                js$inner_html(
                    "#recommended-cities",
                    paste0(
                        "<p class=\"error\">",
                        "Too many filters were applied. As a result, ",
                        "no data was returned. Select more countries or",
                        "reduce the number of cities to be removed.",
                        "</p>"
                    )
                )
            } else {

                #' Get Recommendations
                results <- travel_preferences(
                    weights = w,
                    data = isolate(recs_filtered())
                )

                #' Render Map
                map_data <- results[c(1, 2, 3), ]
                map_data <- map_data[complete.cases(map_data), ]
                viz$render_top_city_maps(map_data)
            }
        }
    })

    #'/////////////////////////////////////////////////////////////////////////

    #' Code for Data Page
    observe({
        if (current_page() == "data") {
            
            #' Write Total Cities
            js$inner_html(
                "#summary-total-cities",
                travel$highlights$cities,
                delay = 750
            )

            #' Write Total Countries
            js$inner_html(
                "#summary-total-countries",
                travel$highlights$countries,
                delay = 750
            )

            #' Render Table removing cities and countries count
            viz$render_datatable(
                id = "#summary-of-data",
                data = travel$highlights$all[-c(1, 2), ],
                columns = names(travel$highlights$all),
                caption = "Count of Places by Type",
                class = "datatable-small"
            )

            #' Format Recommendations Dataset
            ref_data <- recs %>%
                arrange(country, city, tot_n) %>%
                select(id, city, country, brewery, cafe, museum, tot_n) %>%
                rename("total" = tot_n)

            #' Render D3 Table
            viz$render_datatable(
                id = "#reference-table",
                data = ref_data,
                columns = names(ref_data),
                caption = "Reference Data"
            )

            #' Create Event for Reference Table Form
            observeEvent(input$submitRefsForm, {
                refs_filtered <- ref_data
                # apply sort data (this isn't the best feature)
                if (input$refs_table_sort != "none") {
                    #' set vars to reverse sort
                    sort_input <- as.character(input$refs_table_sort)
                    reverse_sort <- c("brewery", "cafe", "museum", "total")
                    if (sort_input %in% reverse_sort) {
                        refs_filtered <- refs_filtered %>%
                            arrange(desc(!!rlang::sym(sort_input)))
                    }
                    # #' otherwise sort in alphabetical
                    if (!sort_input %in% reverse_sort) {
                        refs_filtered <- refs_filtered %>%
                            arrange(!!rlang::sym(sort_input))
                    }
                }
                # filter by countries
                if (length(input$ref_form_country_filter) > 0) {
                    refs_filtered <- refs_filtered %>%
                        filter(country %in% input$ref_form_country_filter)
                }

                viz$render_datatable(
                    id = "#reference-table",
                    data = refs_filtered,
                    columns = names(refs_filtered),
                    caption = "Reference Data"
                )

            })

            #' If Form is selected
            observeEvent(input$resetRefsForm, {
                js$reset_input_groups()
            })
        }
    })
}