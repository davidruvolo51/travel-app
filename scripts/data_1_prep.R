#'//////////////////////////////////////////////////////////////////////////////
#' FILE: data_1_prep.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-12
#' MODIFIED: 2020-02-12
#' PURPOSE: prepare data into viz ready objects
#' STATUS: in.progress
#' PACKAGES: tidyverse
#' COMMENTS: NA
#'//////////////////////////////////////////////////////////////////////////////
options(stringsAsFactors = FALSE)

# pkgs
suppressPackageStartupMessages(library(tidyverse))


#'//////////////////////////////////////////////////////////////////////////////

#' ~ 0 ~
#' Reduce Data
#' In this section, identify duplicate entries and remove them. Load datasets
breweries <- readRDS("data/downloads/breweries_all_cities.RDS")
coffee <- readRDS("data/downloads/coffee_all_cafes.RDS")

#'//////////////////////////////////////

#' ~ A ~
#' Check Breweries Dataset

#' ~ a ~
# check missing values
#' At this point, the number of breweries is around 4k. Let's check the missing
#' variables.
sapply(seq_len(NCOL(breweries)), function(col) {
    list(
        name = names(breweries[col]),
        missing = NROW(breweries[is.na(breweries[, col]) == TRUE, ]),
        percent = round(
            (
                NROW(breweries[is.na(breweries[, col]) == TRUE, ]) /
                NROW(breweries) * 100
            ),
            2
        )
    )
})


#' ~ b ~
#' check unique entries
breweries$duplicated <- as.character(
    sapply(seq_len(NROW(breweries$id)), function(x) {
        result <- breweries$id[breweries$id == breweries$id[x]]
        if (length(result) > 1) {
            return(TRUE)
        } else {
            return(FALSE)
        }
    })
)

#' Check a few cases where there's a duplicated id
breweries %>% filter(duplicated == TRUE) %>% head()
breweries %>% filter(id == "1502898997")

#' Since there are multiple entries for a location, use coordinates to reduce
#' the dataset down to unique breweries only.
breweries <- breweries %>%
    distinct(id, lat, lon, .keep_all = TRUE) %>%
    select(-duplicated)

# Double check ids and rows. These should match. If the numbers do not match,
# continue to evaluate the breweries by id and coordinates. It is likely that
# some breweries have multiple locations. However, this should be addressed by
# id. The cases in this dataset a result of multiple entries of the same place,
# but with two different addresses; more often it was the city that was
# different. If all of the coordinates, ids, and place names are the same, then
# take any distinct value.
NROW(breweries)
length(unique(breweries$id))

#'//////////////////////////////////////

#' ~ B ~
#' Check Coffee Dataset

#' ~ a ~
#' Find missing values
sapply(seq_len(NCOL(coffee)), function(col) {
    list(
        name = names(coffee[col]),
        missing = NROW(coffee[is.na(coffee[, col]) == TRUE, ]),
        blank = NROW(coffee[coffee[, col] == "", ]),
        percent = round(
            (
                NROW(coffee[is.na(coffee[, col]) == TRUE, ]) /
                NROW(coffee) * 100
            ),
            2
        )
    )
})

#' There is one instance where the name was blank. I'm pretty sure this was
#' handled in the early scripts, but perhaps it didn't get saved. Since there
#' is only one case, I will update it manually.

#' Filter dataset for the case with the blank city
coffee %>% filter(city == "")

#' The cafe id is cafe_585 Wldkaffee Rosterie. Use the link provided to find
#' the city and other information
coffee$city[coffee$cafeId == "cafe_585"] <- "Garmisch-Partenkirchen"
coffee$address[coffee$cafeId == "cafe_585"] <- "Bahnhofstr. 8, 82467, Garmisch-Partenkirchen, Germany"
coffee$lat[coffee$cafeId == "cafe_585"] <- 47.493381500
coffee$lng[coffee$cafeId == "cafe_585"] <- 11.103316307
coffee$website[coffee$cafeId == "cafe_585"] <- "https://www.wild-kaffee.de"
coffee$user_ratings_total[coffee$cafeId == "cafe_585"] <- 88
coffee$rating[coffee$cafeId == "cafe_585"] <- 4.8

# View entry
coffee[coffee$cafeId == "cafe_585", ]


#'//////////////////////////////////////

#' ~ c ~
#' Merge Datasets
#' Here, I will merge the two datasets in order to create a summary dataset.
#' The full datasets will be saved for use in the maps, but here I want
#' to reduce the datasets to merge and summarize. Since coffee is the primary
#' focus, I will save ratings data and remove everything else. Corresponding
#' columns will need to be created in the breweries dataset; make sure these
#' receive NA values. From both dadtasets, I am interested in the following
#' variables.
#'
#'      - City
#'      - Country
#'      - Name
#'      - Coordinates (Lat, Long)
#'      - id (i.e., osm id and place_id or cafeID)
#'      - Ratings: user_ratings_total and rating
#'      - Price: price_level
#'
#' Reduce the datasets using the columns above. Also add columns so the struct-
#' ures are the same. Rename and reorder columns


#' reduce breweries and add columns to match the structure of the coffee data
brew <- breweries %>%
    select(
        city,
        country,
        id,
        name,
        lat,
        lon
    ) %>%
    mutate(
        user_ratings_total = NA,
        rating = NA,
        price_level = NA,
        type = "brewery"
    )

#' reduce coffee and add columns to match the structure of the breweries data
cafes <- coffee %>%
    select(
        city,
        country,
        id = cafeId,
        name,
        lat,
        lon = lng,
        user_ratings_total,
        rating,
        price_level
    ) %>%
    mutate(
        type = "cafe"
    )

#' Merge datasets - bind rows
places <- rbind(brew, cafes) %>% arrange(city, country, name, type)

#'//////////////////////////////////////////////////////////////////////////////

#' ~ 1 ~
#' Summarize Data
#' In this section, create an object that contains summarized data that will be
#' used in the data viz. The cleaned datasets (i.e., coffee and breweries) will
#' be saved and used in the interactive map.


#' Create summary object
travel <- list()
travel$highlights <- list()
travel$descriptives <- list()
travel$summary <- list()

#' ~ a ~
#' Find the total number of countries
travel$highlights$countries <- places %>%
    distinct(country) %>%
    count() %>%
    pull()

#' ~ b ~
#' Find the total number of cities
travel$highlights$cities <- places %>%
    distinct(city) %>%
    count() %>%
    pull()

#' ~ c ~
#' Find the total number of places
travel$highlights$places <- places %>%
    distinct(id) %>%
    count() %>%
    pull()

#' ~ d ~
#' Find the total number of cafes
travel$highlights$cafes <- places %>%
    filter(type == "cafe") %>%
    distinct(id) %>%
    count() %>%
    pull()

#' ~ e ~
#' Find the total number of breweries
travel$highlights$breweries <- places %>%
    filter(type == "brewery") %>%
    distinct(id) %>%
    count() %>%
    pull()


#' Check to see if the breweries and cafes count equal the NCOL
travel$highlights$places == NROW(places)
sum(travel$highlights$breweries, travel$highlights$cafes) == NROW(places)

#' ~ f ~
#' Descriptives: Places by City
#' (I don't know if this will be helpful)
travel$descriptives$places_by_city <- places %>%
    group_by(city, type) %>%
    count() %>%
    group_by(type) %>%
    summarize(
        avg = mean(n),
        sd = sd(n)
    )

#' ~ g ~
#' Descriptives: Places by Country
#' (I don't know if this will be helpful)
travel$descriptives$places_by_country <- places %>%
    group_by(country, type) %>%
    count() %>%
    group_by(type) %>%
    summarize(
        mean = mean(n),
        sd = sd(n)
    )

#' ~ h ~
#' Summaries: coffee and breweries by country
travel$summary$places_by_country <- places %>%
    group_by(country, type) %>%
    summarize(
        cities = length(unique(city)),
        places = length(unique(id)),
        user_ratings_mean = mean(user_ratings_total, na.rm = TRUE),
        user_ratings_total = sum(user_ratings_total, na.rm = TRUE),
        rating_avg = mean(rating, na.rm = TRUE),
        rading_sd = sd(rating, na.rm = TRUE),
        price_level = median(price_level, na.rm = TRUE)
    ) %>%
    arrange(country, type)

#' ~ i ~
#' Summary: coffe and breweries by city
travel$summary$places_by_city <- places %>%
    group_by(city, country, type) %>%
    summarize(
        cities = length(unique(city)),
        places = length(unique(id)),
        user_ratings_mean = mean(user_ratings_total, na.rm = TRUE),
        user_ratings_total = sum(user_ratings_total, na.rm = TRUE),
        rating_avg = mean(rating, na.rm = TRUE),
        rading_sd = sd(rating, na.rm = TRUE),
        price_level = median(price_level, na.rm = TRUE)
    ) %>%
    ungroup() %>%
    arrange(country, city, type)

#'//////////////////////////////////////////////////////////////////////////////

#' ~ 2 ~
# save all objects

saveRDS(brew, "data/all_european_breweries.RDS")
saveRDS(cafes, "data/all_european_coffee.RDS")
saveRDS(travel, "data/travel_summary.RDS")