#' ////////////////////////////////////////////////////////////////////////////
#' FILE: search.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-02
#' MODIFIED: 2020-03-05
#' PURPOSE: server code for search page
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

#' ~ 1 ~
#' Define function that filters data and status variable for use in logic
#' that renders visualizations
filterData <- function(data, countries, limits) {
    #' Build Output As List
    d <- list()
    d$status <- TRUE
    d$data <- data

    #' Apply Countries Filter
    if (length(countries) > 0) {
        d$status <- TRUE
        d$data <- d$data %>% filter(country %in% countries)
    }

    #' Apply City Limits
    if (limits > 0 & limits <= NROW(d$data)) {
        d$status <- TRUE
        d$data <- d$data %>%
            arrange(-tot_n) %>%
            slice((limits + 1):NROW(.)) %>%
            as.data.frame(.)
    }

    #' Send FALSE if limits is out of bounds
    if (limits > NROW(d$data) | NROW(d$data) == 0) {
        d$status <- FALSE
    }
    return(d)
}

#'//////////////////////////////////////

#' ~ 2 ~
#' Define data to text functions
txt <- list()

#' Function that recodes weights
txt$format_weights <- function(data) {
    case_when(
        data == -2 ~ "Not at all",
        data == -1 ~ "Tend to avoid",
        data == 0.1 ~ "No Preference",
        data == 1 ~ "Tend to Visit",
        data == 2 ~ "Essential"
    )
}

#' Function that generates list of items as text
txt$format_list <- function(data) {
    if (length(data) == 1) {
        return(data)
    } else if (length(data) == 2) {
        return(paste0(data[1], " or ", data[1]))
    } else if (length(data) == 3) {
        return(paste0(data[1], ", ", data[2], ", or ", data[3]))
    } else {
        return(FALSE)
    }
}

#' ~ 2 ~
#' Define a function that generates recommendations text

#'//////////////////////////////////////

#' ~ 4 ~
#' Functions that return text blocks

#' Recommendations text
generate_recs_text <- function(cities) {
    txt <- paste0(
        "Based on the selections you made, you may enjoy",
        " visiting ", txt$format_list(cities), "."
    )
    return(txt)
}

#'//////////////////////////////////////

#' Define server code for search page
observe({
    if (current_page() == "search") {

        #' Server Code for Finder Tab
        validated <- reactiveVal(FALSE)
        has_error <- reactiveVal(FALSE)
        show_report <- reactiveVal(FALSE)
        city_limits <- reactiveVal(0)
        country_limits <- reactiveVal("")
        brewery_prefs <- reactiveVal(0.1)
        coffee_prefs <- reactiveVal(0.1)
        museum_prefs <- reactiveVal(0.1)

        #'//////////////////////////////////////
        #' Run Code for Data
        observeEvent(input$submitTravelForm, {

            #' Set ReactiveVals
            city_limits(input$option_city_limits)
            country_limits(input$country_limits)
            brewery_prefs(input$breweryPrefs)
            coffee_prefs(input$coffeePrefs)
            museum_prefs(input$museumPrefs)

            #' Reset Form only if there is an error
            if (isTRUE(has_error())) {
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
            if (class(city_limits()) != "integer" | city_limits() > 50 | city_limits() < 0) {
                #' Update Reactive Values and Client
                has_error(TRUE)
                js$remove_css(
                    elem = "#travel-form-error",
                    css = "visually-hidden"
                )
                js$remove_css(
                    elem = "#limit-results-error",
                    css = "visually-hidden"
                )
                js$remove_element_attribute(
                    elem = "#travel-form-error",
                    attr = "aria-hidden"
                )
                js$remove_element_attribute(
                    elem = "#limit-results-error",
                    attr = "aria-hidden"
                )

                #' Send Error Messages
                js$inner_html(
                    elem = "#travel-form-error",
                    string = "ERROR: A problem occurred with 'limit results'"
                )
                js$inner_html(
                    elem = "#limit-results-error",
                    string = "ERROR: Enter a number from 0 to 50"
                )
            } else {

                #' Reset Reactive Val for error
                has_error(FALSE)

                #' Reveal report on the first time only
                if (isFALSE(show_report())) {
                    js$remove_css(
                        elem = "#travel-summary",
                        css = "visually-hidden"
                    )
                    show_report(TRUE)
                }

                #' Prep weights - weights must be in alphabetical order
                w <- c(brewery_prefs(), coffee_prefs(), museum_prefs())

                #' Filter User Preferences Based on Recs
                recs_filtered <- filterData(
                    recs,
                    country_limits(),
                    city_limits()
                )

                #' Render Charts Based on Filtered Status
                if (isFALSE(recs_filtered$status)) {
                    js$inner_html(
                        elem = "#recommended-cities",
                        string = paste0(
                            "<p class=\"error\">",
                            "Too many filters were applied. As a result, ",
                            "no data was returned. Select more countries or",
                            "reduce the number of cities to be removed.",
                            "</p>"
                        )
                    )
                }

                #' Render only if true
                if (isTRUE(recs_filtered$status)) {

                    #' Get Recommendations
                    results <- travel_preferences(
                        weights = w,
                        data = recs_filtered$data
                    )

                    #' js$console_log(
                    #'     list(
                    #'         weights = w,
                    #'         cities = city_limits(),
                    #'         countries = country_limits()
                    #'     )
                    #' )

                    #' Render Map
                    cities_map <- results[c(1, 2, 3), ]
                    cities_map <- cities_map[complete.cases(cities_map), ]
                    viz$render_top_city_maps(cities_map)

                    #' Render Text Blocks
                    recs_text <- generate_recs_text(cities_map$city)
                    js$inner_html(
                        elem = "#recommended-cities-summary",
                        string = recs_text
                    )

                    #' Render Summary Datatable
                    cities_table <- recs %>%
                        filter(id %in% cities_map$id) %>%
                        select(id, city, country, brewery, cafe, museum) %>%
                        left_join(
                            cities_map %>% select(id, score),
                            by = "id"
                        ) %>%
                        mutate(
                            score = round(score, 2)
                        ) %>%
                        arrange(-score)

                    #' Render D3 Table
                    viz$render_datatable(
                        "#summary-of-recommended-cities",
                        cities_table,
                        names(cities_table)
                    )
                }
            }
        }, ignoreInit = TRUE)
    }
})