#' ////////////////////////////////////////////////////////////////////////////
#' FILE: travel_finder.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-17
#' MODIFIED: 2020-02-18
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
#'         readRDS("data/downloads/cafe_cities_geocoded.RDS") %>%
#'             rowid_to_column("id") %>%
#'             select(id, city),
#'         by = "city"
#'     ) %>%
#'     select(id, everything()) %>%
#'     as.data.frame()
#'
#' Save Transformed Data for Use in Application.
#' saveRDS(travel, "data/travel_recommendations.RDS")

#' Define a function that returns all cities in the dataset where each city is
#' given a new score based on user preferences. The score is a weighted mean
#' that is weighted by a user's selection and rating of place type (i.e.,
#' cafes, breweries, museums).
#' recs <- readRDS("data/travel_recommendations.RDS")
travel_preferences <- function(weights, ratings, limits = FALSE, data = recs) {

    #' Define a function that returns the limits
    new_limits <- function(limits) {
        top_50 <- c(
            162, 1, 281, 56, 278, 341, 139, 269, 98, 57, 322, 301, 70,
            210, 248, 239, 191, 192, 58, 63, 362, 393, 174, 55, 74,
            138, 229, 249, 165, 221, 221, 211, 335, 68, 60, 250, 370,
            300, 345, 29, 163, 349, 286, 403, 168, 380, 264, 61, 14, 85
        )
        return(top_50[1:limits])
    }

    #' Define a function that takes the master dataset and selected first n
    internal_ref_df <- function(data, limits) {
        if (!isFALSE(limits)) {
            lim <- new_limits(limits = limits)
            return(data[!data$id %in% lim, ])
        }
        if (isFALSE(limits)) {
            return(data)
        }
    }

    #' Define a function that returns the reference dataset
    new_refs <- function(data) {
        return(as.matrix(data[, c("brewery", "cafe", "museum")]))
    }

    #' Define a function that builds a blank user preferences object
    new_prefs <- function(data) {
        data.frame(
            id = data$id,
            city = data$city,
            country = data$country,
            data[, c("brewery", "cafe", "museum")] * 0,
            score = 0,
            stringsAsFactors = FALSE
        )
    }

    #' Make sure input arguments are number
    #' the weights are whether or not the user has selected a place type
    #' the ratings are how strongly the user felt about each type
    user_weights <- as.numeric(weights)
    user_ratings <- as.numeric(ratings)

    #' Create Required Data Structures
    internal_df <- internal_ref_df(data = data, limits = limits)
    cities_mat <- new_refs(data = internal_df)
    prefs <- new_prefs(data = internal_df)

    #' Build a new score per city that is a the number of places by type
    #' weighted by selection status and ratings per place type dividing by
    #' weights
    for (d in seq_len(NROW(cities_mat))) {

        #' Caclulate Scores for City based on weights and rating
        scores <- (cities_mat[d, ] * user_weights + user_ratings) /
            (user_weights + 1)

        #' Append to Preferences Object
        prefs[d, c("brewery", "cafe", "museum", "score")] <- cbind(
            rbind(scores),
            score = sum(scores)
        )
    }

    #' Return
    return(prefs[order(prefs$score, decreasing = TRUE), ])
}

#' Run a few tests
#' travel_preferences(weights = c(1, 1, 0), ratings = c(3, 3, 0))
#' travel_preferences(weights = c(0, 1, 0), ratings = c(0, 3, 0))
#' travel_preferences(
#'     weights = c(0, 1, 1),
#'     ratings = c(0, 4, 3),
#'     limits = 10
#' )