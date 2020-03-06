#' ////////////////////////////////////////////////////////////////////////////
#' FILE: routing.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-02
#' MODIFIED: 2020-03-05
#' PURPOSE: app routing
#' STATUS: complete; working
#' PACKAGES: browsertools
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
observeEvent(input$home, {
    if (current_page() != "home") {

        #' remove aria-current attribute from current page
        js$remove_element_attribute(
            elem = paste0("#", current_page()),
            attr = "aria-current"
        )

        #' add aria-current to new page
        js$set_element_attribute(
            elem = "#home",
            attr = "aria-current",
            value = "page"
        )

        #' update reactive value and render page
        current_page("home")
        output$page <- renderUI(home_page())

        #' reset View
        js$scroll_to_top()
    }
})

#' Switch to Finder Page
observeEvent(input$search, {
    if (current_page() != "search") {

        #' remove aria-current attribute from current page
        js$remove_element_attribute(
            elem = paste0("#", current_page()),
            attr = "aria-current"
        )

        #' add aria-current to new page
        js$set_element_attribute(
            elem = "#search",
            attr = "aria-current",
            value = "page"
        )

        #' update reactive value and render page
        current_page("search")
        output$page <- renderUI(search_page())

        #' reset View
        js$scroll_to_top()
    }
})

#' Switch to Finder Page
observeEvent(input$appStart, {

    #' remove aria-current attribute from current page
    js$remove_element_attribute(
        elem = paste0("#", current_page()),
        attr = "aria-current"
    )

    #' add aria-current to new page
    js$set_element_attribute(
        elem = "#search",
        attr = "aria-current",
        value = "page"
    )

    #' update reactive value and render page
    current_page("search")
    output$page <- renderUI(search_page())

    #' reset View
    js$scroll_to_top()
})

#' Switch to Explorer Page
observeEvent(input$map, {
    if (current_page() != "map") {

        #' remove aria-current attribute from current page
        js$remove_element_attribute(
            elem = paste0("#", current_page()),
            attr = "aria-current"
        )

        #' add aria-current to new page
        js$set_element_attribute(
            elem = "#map",
            attr = "aria-current",
            value = "page"
        )

        #' update reactive value and render page
        current_page("map")
        output$page <- renderUI(map_page())

        #' reset View
        js$scroll_to_top()
    }
})

#' Swicth to Data Page
observeEvent(input$data, {
    if (current_page() != "data") {

        #' remove aria-current attribute from current page
        js$remove_element_attribute(
            elem = paste0("#", current_page()),
            attr = "aria-current"
        )

        #' add aria-current to new page
        js$set_element_attribute(
            elem = "#data",
            attr = "aria-current",
            value = "page"
        )

        #' update reactive value and render page
        current_page("data")
        output$page <- renderUI(data_page())

        #' reset View
        js$scroll_to_top()
    }
})