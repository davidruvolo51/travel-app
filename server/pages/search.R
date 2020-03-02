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
        weights == -2 ~ "Not at all",
        weights == -1 ~ "Tend to avoid",
        weights == 0.1 ~ "No Preference",
        weights == 1 ~ "Tend to Visit",
        weights == 2 ~ "Essential"
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
        " visiting ", txt$format_cities(cities), "."
    )
    return(txt)
}

#' Summary Text
generate_sum_text <- function(cities, countries, weights) {
    # convert weights to text
    inputs <- as.character(sapply(weights, txt$format_weights))
    selection <- paste0(
        "Breweries: \"", inputs[1], "\", ",
        "Cafes: \"", inputs[2], "\", and ",
        "Museums: \"", inputs[3], "\""
    )

    #' Generate Countries Text
    country_processed <- txt$format_list(countries)
    if (isTRUE(country_processed)) {
        country_text <- paste0(
            "was limited to places in ",
            country_processed
        )
    }
    if (isFALSE(country_processed)) {
        country_text <- "was not filtered for any countries"
    }

    #' Generate Cities Text
    if (length(cities) == 1) {
        city_text <- paste0(
            "The top ", length(cities), "city was also removed"
        )
    } else if (length(cities) > 1) {
        city_text <- paste0(
            "The top ", length(cities), "cities were also removed"
        )
    } else {
        city_text <- paste0(
            "No cities were removed"
        )
    }
    #' Process Countries
    txt <- paste0(
        "So why were ", txt$format_list(cities), " recommended?",
        "Based on your preferences - ", selection, "- ", "all cities were",
        "scored and ranked accordingly.", "The data ", country_text, ". ",
        city_text, "from the results."
    )
    return(text)
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
        country_limits <- reactiveVal(FALSE)

        #' Run Code for Data
        observeEvent(input$submitTravelForm, {

            #' Set ReactiveVals
            city_limits(input$option_city_limits)
            country_limits(input$country_limits)

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
                js$remove_css("#travel-form-error", "visually-hidden")
                js$remove_css("#limit-results-error", "visually-hidden")
                js$remove_element_attribute("#travel-form-error", "aria-hidden")
                js$remove_element_attribute(
                    "#limit-results-error",
                    "aria-hidden"
                )

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
                has_error(FALSE)

                #' Reveal report on the first time only
                if (isFALSE(show_report())) {
                    js$remove_css("#travel-summary", "visually-hidden")
                    show_report(TRUE)
                }

                #' Prep weights
                w <- c(
                    as.numeric(input$breweryPrefs),
                    as.numeric(input$coffeePrefs),
                    as.numeric(input$museumPrefs)
                )
                js$console_log(w)

                #' Filter User Preferences Based on Recs
                recs_filtered <- filterData(
                    recs,
                    country_limits(),
                    city_limits()
                )

                #' Render Charts Based on Filtered Status
                if (isFALSE(recs_filtered$status)) {
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
                }

                #' Render only if true
                if (isTRUE(recs_filtered$status)) {

                    #' Get Recommendations
                    results <- travel_preferences(
                        weights = w,
                        data = isolate(recs_filtered$data)
                    )

                    #' Render Map
                    cities_map <- results[c(1, 2, 3), ]
                    cities_map <- cities_map[complete.cases(cities_map), ]
                    viz$render_top_city_maps(cities_map)

                    #' Render Text
                    recs_text <- generate_recs_text(cities_map$city)
                    js$inner_html("#recommended-cities-summary", recs_text)

                    #' Render Charts
                    cities_sum <- places %>%
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