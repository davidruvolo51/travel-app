#' ////////////////////////////////////////////////////////////////////////////
#' FILE: travel_finder.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-17
#' MODIFIED: 2020-02-24
#' PURPOSE: primary function for finding cities
#' STATUS: working; complete
#' PACKAGES: tidyverse (only for data prep)
#' COMMENTS: This script contains the function for generating recommendations
#' based on user preferences. It uses the object `travel` which is the count
#' of places for each city. In the application, the user selects and rate the
#' place types that they find important. The function calculates a new score
#' for each city based on the user preferences and returns the whole list, as
#' well as the scores for each place type. This function also allows for the
#' results to exclude the top 10 cities with the most places. The results
#' tend to biased for larger cities. Weights and Ratings were added to even
#' the results, but larger cities will still be among the top cities. Adding a
#' remove top 10 option might help with that issue. To find the top 10 cities,
#' run the following code in the console:
#'
#' recs %>%
#'      arrange(-tot_n) %>%
#'      head(25) %>%
#'      pull(id) %>%
#'      paste0(collapse=", ")
#'
#' ////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

#' pkgs
#' suppressPackageStartupMessages(library(tidyverse))
#' Prep Data
#' To prep the data for use in the function, uncomment the following lines.
#' This code loads the travel summary object and extracted ths summarized obj
#' "places_by_city". Since the aim of the application is to provide
#' recommendations for cities, we do not need to worry about the country
#' level summary. After loading the object in, transform the data so that
#' all counts of place type in each city are in a single row. Save this new
#' object separately for use in the application.
#' travel <-
#' readRDS("data/travel_summary.RDS")[["descriptives"]][["places_by_city"]] %>%
#'     select(city, country, type, n, "tot_n" = tot_city_places) %>%
#'     pivot_wider(
#'         names_from = type,
#'         values_from = n,
#'         values_fill = list(n = 0)
#'     ) %>%
#'     left_join(
#'         readRDS("data/travel_all_cities_geocoded.RDS") %>%
#'             select(id, city, lat, lng),
#'         by = "city"
#'     ) %>%
#'     select(id, city, country, lat, lng, everything()) %>%
#'     as.data.frame()
#'
#' Save Transformed Data for Use in Application.
#' saveRDS(travel, "data/travel_recommendations.RDS")
#' Define a function that returns all cities in the dataset where each city is
#' given a new score based on user preferences. The score is a weighted mean
#' that is weighted by a user's prefernces for each place type (i.e.,
#' cafes, breweries, museums).
#' recs <- readRDS("data/travel_recommendations.RDS")
travel_preferences <- function(weights, data) {

    #' Define a function that builds a blank user preferences object
    new_prefs <- function(data) {
        data.frame(
            id = data$id,
            city = data$city,
            country = data$country,
            lat = data$lat,
            lng = data$lng,
            data[, c("brewery", "cafe", "museum")] * 0,
            score = 0,
            stringsAsFactors = FALSE
        )
    }

    #' Create Required Objects (weights, references, and preferences)
    user_weights <- as.numeric(weights)
    refs <- as.matrix(data[, c("brewery", "cafe", "museum")])
    prefs <- new_prefs(data = data)

    #' Build a new score per city (weighted mean). I'm using my own
    #' weighted means formula in case I want to use the subscores in
    #' the app
    for (d in seq_len(NROW(refs))) {
        scores <- (refs[d, ] * user_weights)
        prefs[d, c("brewery", "cafe", "museum", "score")] <- cbind(
            rbind(scores),
            score = sum(scores) / sum(user_weights)
        )
    }

    #' Return
    return(prefs[order(prefs$score, decreasing = TRUE), ])
}

#' Test
#' travel_preferences(weights = c(-2, 1, 2))
