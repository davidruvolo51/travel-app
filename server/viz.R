#'////////////////////////////////////////////////////////////////////////////
#' FILE: viz.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-21
#' MODIFIED: 2020-02-21
#' PURPOSE: shiny handlers for d3 modules
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#'////////////////////////////////////////////////////////////////////////////

#' "Modularize" functions
viz <- list()

#' get session
viz$get_shiny_session <- function() {
    return(shiny::getDefaultReactiveDomain())
}

#' Function to prep d3 json object
viz$as_json_object <- function(data) {
    parent <- list()
    lapply(seq_len(NROW(data)), function(row) {
        child <- list()
        lapply(seq_len(NCOL(data)), function(col) {
            child[[col]] <<- data[row, col]
            names(child)[[col]] <<- colnames(data)[col]
        })
        parent[[row]] <<- child
    })
    return(parent)
}

#' Render Top Cities Maps
viz$render_top_city_maps <- function(data) {
    session <- viz$get_shiny_session()
    out <- viz$as_json_object(data)
    session$sendCustomMessage("render_top_city_maps", out)
}

#' Render Datatable
viz$render_datatable <- function(id, data, columns, caption = NULL) {
    session <- viz$get_shiny_session()
    out <- viz$as_json_object(data)
    session$sendCustomMessage("render_datatable", list(id, out, columns, caption))
}