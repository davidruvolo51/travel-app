#' ////////////////////////////////////////////////////////////////////////////
#' FILE: search.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-02
#' MODIFIED: 2020-03-02
#' PURPOSE: server code for search page
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
observe({
    if (current_page() == "search") {
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
                    cities_map <- results[c(1, 2, 3), ]
                    cities_map <- cities_map[complete.cases(cities_map), ]
                    viz$render_top_city_maps(cities_map)

                    #' Render Charts
                    cities_sum <- recs_filtered() %>%
                        filter(id %in% cities_map$id) %>%
                        mutate(
                            id = factor(id, unique(cities_map$id))
                        ) %>%
                        arrange(id) %>%
                        as.data.frame()
                    viz$render_city_column_charts(cities_sum)
                }
            }
        })
    }
})