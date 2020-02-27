#'////////////////////////////////////////////////////////////////////////////
#' FILE: handlers.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-21
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

#' Trigger a Page Refresh
js$refresh_page <- function() {
    session <- js$get_shiny_session()
    session$sendCustomMessage("refresh_page", "")
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

#' Toggle a css class of an element
js$toggle_css <- function(elem, css) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("toggle_css", list(elem, css))
}

#' Show Element by removing class "hidden"
js$show_elem <- function(elem, css = NULL) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("show_elem", list(elem, css))
}

#' Hide element by adding class "hidden"
js$hide_elem <- function(elem, css = NULL) {
    session <- js$get_shiny_session()
    session$sendCustomMessage("hide_elem", list(elem, css))
}