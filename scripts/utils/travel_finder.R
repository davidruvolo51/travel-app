#' ////////////////////////////////////////////////////////////////////////////
#' FILE: travel_finder.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-17
#' MODIFIED: 2020-02-17
#' PURPOSE: primary function for finding cities
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

#' pkgs
suppressPackageStartupMessages(library(tidyverse))

#' data
raw <- readRDS("data/travel_summary.RDS")[["descriptives"]][["places_by_city"]]

#' transform data for preferences function
travel <- raw %>%
    select(city, country, type, n) %>%
    pivot_wider(
        names_from = type,
        values_from = n,
        values_fill = list(n = 0)
    ) %>%
    as.data.frame()

#' Define a function that returns all cities in the dataset where each city is
#' given a new score based on user preferences. The score is a weighted mean
#' that is weighted by a user's selection and rating of place type (i.e.,
#' cafes, breweries, museums).
travel_preferences <- function(weights, ratings) {

    #' Define a function that builds a blank user preferences object
    new_prefs <- function() {
        data.frame(
            city = travel$city,
            travel[, c("brewery", "cafe", "museum")] * 0,
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
    cities_mat <- as.matrix(travel[, c("brewery", "cafe", "museum")])
    prefs <- new_prefs()

    #' Build a new score per city that is a the number of places by type
    #' weighted by selection status and ratings per place type dividing by
    #' weights
    for (d in seq_len(NROW(travel))) {
        scores <- (cities_mat[d, ] * user_weights + user_ratings) /
            (user_weights + 1)
        prefs[d, 2:5] <- cbind(rbind(scores), score = sum(scores))
    }

    #' Return
    return(prefs[order(prefs$score), ])
}

travel_preferences(weights = c(1, 1, 0), ratings = c(3, 3, 0))