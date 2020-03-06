#'////////////////////////////////////////////////////////////////////////////
#' FILE: index.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-03-05
#' PURPOSE: A collection of js handlers for use in shiny apps
#' STATUS: working
#' PACKAGES: NA
#' COMMENTS: see src/js/* for corresponding js code
#'////////////////////////////////////////////////////////////////////////////

#' Define object
js <- list()

#' Retrieve the session
js$get_shiny_session <- function() {
    return(shiny::getDefaultReactiveDomain())
}

#' Add a css class to an element
js$add_css <- function(elem, css) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("add_css", list(elem, css))
}

#' Clear an input
js$clear_input <- function(elem, value = NULL) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("clear_input", list(elem, value))
}

#' Log a value to the console
js$console_log <- function(x, asDir = TRUE) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("console_log", list(x, asDir))
}

#' Set inner html of am element
js$inner_html <- function(elem, string, delay = NULL) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("inner_html", list(elem, string, delay))
}

#' Remove a css class of an element
js$remove_css <- function(elem, css) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("remove_css", list(elem, css))
}

#' Remove html element
js$remove_elem <- function(elem) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("remove_elem", list(elem))
}

#' Remove an html attribute from an element
js$remove_element_attribute <- function(elem, attr) {
    session <- js$get_shiny_session()
    session$sendCustomMessage(
        "remove_element_attribute",
        list(elem, attr)
    )
}

#' Reset Input Groups
js$reset_input_groups <- function() {
    session <- js$get_shiny_session()
    session$sendCustomMessage(
        "reset_input_groups",
        ""
    )
}

#' Reset Form
js$reset_form <- function(id) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("reset_form", id)
}

#' Scroll to the Top of a page
js$scroll_to_top <- function() {
    session <- js$get_shiny_session()
    session$sendCustomMessage("scroll_to_top", "")
}

#' Set an html attribute of an element
js$set_element_attribute <- function(elem, attr, value) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("set_element_attribute", list(elem, attr, value))
}

#'//////////////////////////////////////

#' Visualization Handlers
viz <- list()

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
    session <- js$get_shiny_session()
    out <- viz$as_json_object(data)
    session$sendCustomMessage("render_top_city_maps", out)
}

#' Render Datatable
viz$render_datatable <- function(id, data, columns, caption = NULL, class = NULL) {
    session <- js$get_shiny_session()
    out <- viz$as_json_object(data)
    session$sendCustomMessage(
        "render_datatable",
        list(id, out, columns, caption, class)
    )
}