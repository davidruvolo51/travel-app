#' ////////////////////////////////////////////////////////////////////////////
#' FILE: routing.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-02
#' MODIFIED: 2020-03-02
#' PURPOSE: app routing
#' STATUS: in.progress
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
observeEvent(input$home, {
    if (current_page() != "home") {
        js$remove_element_attribute(
            paste0("#", current_page()),
            "aria-current"
        )
        js$set_element_attribute("#home", "aria-current", "page")
        current_page("home")
        output$page <- renderUI(home_page())
        js$scroll_to_top()
    }
})

#' Switch to Finder Page
observeEvent(input$search, {
    if (current_page() != "search") {
        js$remove_element_attribute(
            paste0("#", current_page()),
            "aria-current"
        )
        js$set_element_attribute("#search", "aria-current", "page")
        current_page("search")
        output$page <- renderUI(search_page())
        js$scroll_to_top()
    }
})

#' Switch to Finder Page
observeEvent(input$appStart, {
    js$remove_element_attribute(
        paste0("#", current_page()),
        "aria-current"
    )
    js$set_element_attribute("#search", "aria-current", "page")
    current_page("search")
    output$page <- renderUI(search_page())
    js$scroll_to_top()
})

#' Switch to Explorer Page
observeEvent(input$map, {
    if (current_page() != "map") {
        js$remove_element_attribute(
            paste0("#", current_page()),
            "aria-current"
        )
        js$set_element_attribute("#map", "aria-current", "page")
        current_page("map")
        output$page <- renderUI(map_page())
        js$scroll_to_top()
    }
})

#' Swicth to Data Page
observeEvent(input$data, {
    if (current_page() != "data") {

        # Update Routing
        js$remove_element_attribute(
            paste0("#", current_page()),
            "aria-current"
        )
        js$set_element_attribute("#data", "aria-current", "page")
        current_page("data")
        output$page <- renderUI(data_page())
        js$scroll_to_top()
    }
})