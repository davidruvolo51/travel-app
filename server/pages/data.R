#' ////////////////////////////////////////////////////////////////////////////
#' FILE: data.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-03-02
#' MODIFIED: 2020-03-05
#' PURPOSE: server code for data page
#' STATUS: working;
#' PACKAGES: NA
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
observe({
    if (current_page() == "data") {

        #' Write Total Cities
        js$inner_html(
            elem = "#summary-total-cities",
            string = travel$highlights$cities,
            delay = 750
        )

        #' Write Total Countries
        js$inner_html(
            elem = "#summary-total-countries",
            string = travel$highlights$countries,
            delay = 750
        )

        #' Render Table removing cities and countries count
        viz$render_datatable(
            id = "#summary-of-data",
            data = travel$highlights$all[-c(1, 2), ],
            columns = names(travel$highlights$all),
            caption = "Count of Places by Type",
            class = "datatable-small"
        )

        #' Format Recommendations Dataset
        ref_data <- recs %>%
            arrange(country, city, tot_n) %>%
            select(id, city, country, brewery, cafe, museum, tot_n) %>%
            rename("total" = tot_n)

        #' Render D3 Table
        viz$render_datatable(
            id = "#reference-table",
            data = ref_data,
            columns = names(ref_data),
            caption = "Reference Data"
        )

        #' Create Event for Reference Table Form
        observeEvent(input$submitRefsForm, {
            refs_filtered <- ref_data
            # apply sort data (this isn't the best feature)
            if (input$refs_table_sort != "none") {
                #' set vars to reverse sort
                sort_input <- as.character(input$refs_table_sort)
                reverse_sort <- c("brewery", "cafe", "museum", "total")
                if (sort_input %in% reverse_sort) {
                    refs_filtered <- refs_filtered %>%
                        arrange(desc(!!rlang::sym(sort_input)))
                }
                # #' otherwise sort in alphabetical
                if (!sort_input %in% reverse_sort) {
                    refs_filtered <- refs_filtered %>%
                        arrange(!!rlang::sym(sort_input))
                }
            }
            # filter by countries
            if (length(input$ref_form_country_filter) > 0) {
                refs_filtered <- refs_filtered %>%
                    filter(country %in% input$ref_form_country_filter)
            }

            viz$render_datatable(
                id = "#reference-table",
                data = refs_filtered,
                columns = names(refs_filtered),
                caption = "Reference Data"
            )
        })
    }
})