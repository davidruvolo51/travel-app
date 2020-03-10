#'////////////////////////////////////////////////////////////////////////////
#' FILE: data.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-03-10
#' PURPOSE: ui page component for data page
#' STATUS: working
#' PACKAGES: shiny; see global
#' COMMENTS: import page in server and use reactiveVal current_page to
#'          dynamically load pages
#'////////////////////////////////////////////////////////////////////////////
data_page <- function() {
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
                "On this page, you can view the summarized datasets",
                "used in the app. The first table provides an overview",
                "of the dataset. The second table displays the",
                "dataset used to generate the city recommendations."
            )
        ),
        tags$section(
            id = "summary-of-data",
            class = "section",
            tags$h2("Summary of Data"),
            tags$p(
                "The following table lists the number of",
                "locations by type. In total, there are",
                tags$output(id = "summary-total-cities"), "cities across",
                tags$output(id = "summary-total-countries"), "countries."
            )
        ),
        tags$section(
            id = "reference-table",
            class = "section",
            tags$h2("Recommendations Dataset"),
            tags$p(
                "The following table displays the number of locations by type",
                "for all cities. This data is used to produce the list of ",
                "recommended cities. Use the filters below to limit and",
                "sort the results."
            ),
            tags$form(
                class = "form",
                tags$label(
                    `for` = "refs_table_sort",
                    "Sort Data by Variable"
                ),
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
                        "Filter the data by country"
                    ),
                    tags$fieldset(
                            id = "ref_form_country_filter",
                            class = "shiny-input-checkboxgroup checkboxes",
                            role = "checkboxgroup",
                            src$country_filter(
                                id = "ref_form_country_filter"
                            )
                    )
                ),
                # Form buttons
                tags$div(
                    class = "b-list",
                    tags$button(
                        id = "submitRefsForm",
                        class = "action-button shiny-bound-input b b-primary",
                        "Submit"
                    )
                )
            )
        ),
        # Call JavaScript Functions
        tags$script("setTimeout(function() { accordions.addToggles()}, 450);")
    )
}