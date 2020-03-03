#'////////////////////////////////////////////////////////////////////////////
#' FILE: data.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-27
#' PURPOSE: ui page component for data page
#' STATUS: in.progress
#' PACKAGES: shiny; see global
#' COMMENTS: import page in server and use reactiveVal current_page to
#'          dynamically load pages
#'////////////////////////////////////////////////////////////////////////////
data_page <- function() {

    # functional component for country filters
    rec_country_filter <- function(id) {
        countries <- sort(unique(recs$country))
        boxes <- lapply(seq_len(length(countries)), function(d) {
            src$checkBoxInput(
                name  = id,
                label = countries[d],
                value = countries[d]
            )
        })
        rm(countries)
        return(boxes)
    }

    # Render
    tags$main(
        id = "data-page",
        class = "main main-extra-top-spacing",
        tags$header(
            id = "hero-data",
            class = "hero hero-small",
            tags$div(class = "hero-content",
                tags$img(
                    class = "illustration size-small camera",
                    src = "images/camera-illustration.svg"
                ),
                tags$h1("Data"),
                tags$h2("View the Data")
            )
        ),
        tags$section(
            id = "data-intro",
            class = "section",
            tags$h2("About"),
            tags$p(
                "On this page, you can view all of the summarized datasets",
                "used in the app. The data is sourced from multiple sources.",
                "All data is based on cities where there is a specialty",
                "coffee scene as listed on",
                tags$a(
                    href = "https://europeancoffeetrip.com",
                    "European Coffee Trip"
                ),
                ". Using the city guides as a reference point,",
                tags$a(
                    href = "http://overpass-api.de",
                    "Overpass API"
                ),
                "queries were run to find museums and breweries located in",
                "each city. The data was merged and summarized to create a",
                "dataset for generating user preferences and recommendations.",
                "As a result, each city contains at least one cafe and the",
                "recommendations are based on these cities.",
                "The source code and data files can be found in the",
                tags$a(
                    href = "https://github.com/davidruvolo51/travel-app-data",
                    "data repository"
                ), ".",
            )
        ),
        tags$section(
            id = "summary-of-data",
            class = "section",
            tags$h2("Summary of Data"),
            tags$p(
                "The following table provides a overview of the number of",
                "places by type. In total, there are",
                tags$output(id = "summary-total-cities"), "cities across",
                tags$output(id = "summary-total-countries"), "countries."
            )
        ),
        tags$section(
            id = "reference-table",
            class = "section",
            tags$h2("Recommendations Dataset"),
            tags$p(
                "The following table displays the dataset used to generate",
                "city recommendations. Use the options below to filter the",
                "dataset."
            ),
            tags$form(
                class = "form",
                src$accordion(
                    id = "refs_table_form",
                    heading = "Filter Data",
                    tags$label("Sort Data by Variable"),
                    tags$fieldset(
                        id = "refs_table_sort",
                        class = "shiny-input-radiogroup radios sort-radio",
                        role = "radiogroup",
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "None",
                            value = "none",
                            checked = TRUE
                        ),
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "ID",
                            value = "id"
                        ),
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "City",
                            value = "city"
                        ),
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "Country",
                            value = "country"
                        ),
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "Brewery",
                            value = "brewery"
                        ),
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "Cafe",
                            value = "cafe"
                        ),
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "Museum",
                            value = "museum"
                        ),
                        src$radioInput(
                            name = "refs_table_sort",
                            label = "Total",
                            value = "total"
                        )
                    ),
                    src$accordion(
                        id = "ref_countries_fieldset",
                        heading = "Limit Results to Specific Countries",
                        tags$p(
                            "Select any number of countries to display in the",
                            "table below."
                        ),
                        tags$fieldset(
                                id = "ref_form_country_filter",
                                class = "shiny-input-checkboxgroup checkboxes",
                                role = "checkboxgroup",
                                rec_country_filter(
                                    id = "ref_form_country_filter"
                                )
                        )
                    ),
                    # Form buttons
                    tags$div(
                        class = "b-list",
                        tags$button(
                            id = "resetRefsForm",
                            class = "action-button shiny-bound-input b b-secondary",
                            "Reset"
                        ),
                        tags$button(
                            id = "submitRefsForm",
                            class = "action-button shiny-bound-input b b-primary",
                            "Submit"
                        )
                    )
                )
            )
        ),
        # Call JavaScript Functions
        tags$script("setTimeout(function() { accordions.addToggles()}, 450);")
    )
}