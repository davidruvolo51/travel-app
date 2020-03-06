#' ////////////////////////////////////////////////////////////////////////////
#' FILE: data_99_utils.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-04
#' MODIFIED: 2020-03-05
#' PURPOSE: function to convert dataframe into geojson object
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
as_geojson_point <- function(data, id, lat, lon, properties = NULL) {
    # validate data object
    object <- deparse(substitute(data))
    obj_exists <- exists(object, parent.frame())
    if (obj_exists == FALSE) {
        msg <- paste0("Object '", object, "' cannot be found.")
        stop(msg)
    }

    # pull properties or assign all
    if (length(properties) > 0) {
        props <- data[, c(properties)]
    } else {
        props <- data[, names(data)]
    }

    # build parent list
    pl <- list(
        type = "FeatureCollection",
        totalFeatures = length(unique(data[, id])),
        features = list()
    )

    # build child elements
    x <- 1
    max.reps <- NROW(data)
    while (x <= max.reps) {
        pl$features[[x]] <- list(
            type = "Feature",
            id = data[x, id],
            geometry = list(
                type = "Point",
                coordinates = list(
                    as.numeric(data[x, lon]),
                    as.numeric(data[x, lat])
                )
            ),
            properties = as.list(props[x, ])
        )
        x <- x + 1
    }
    return(pl)
}

# test
#' d <- data.frame(
#'     id = letters[1:5],
#'     group = paste0("group_", letters[1:5]),
#'     x = rnorm(5, 50),
#'     y = rnorm(5, 40),
#'     stringsAsFactors = FALSE
#' )
#' x <- as_geojson_point(
#'     data = d,
#'     id = "id",
#'     lon = "x",
#'     lat = "y",
#'     properties = c("id", "group")
#' )
