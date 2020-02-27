#' ////////////////////////////////////////////////////////////////////////////
#' FILE: search.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-27
#' PURPOSE: ui page component for search tab
#' STATUS: in.progress
#' PACKAGES: shiny; custom handlers; sass; babel; D3
#' COMMENTS: load page in server and use reactiveVal "current_page" to render
#'           pages dynamically (application routing)
#' ////////////////////////////////////////////////////////////////////////////
search_page <- function() {

    # define country filter
    country_filter <- function() {
        countries <- sort(unique(recs$country))
        boxes <- lapply(seq_len(length(countries)), function(d) {
            src$checkBoxInput(
                name  = "countryFilter",
                label = countries[d],
                value = countries[d]
            )
        })
        rm(countries)
        return(boxes)
    }

    # set user preferences buttons function
    user_prefs_ui <- function(id) {
        tagList(
            #' Strongest Negative Weighting
            src$radioInput(
                name = id,
                label = "Not at all",
                value = -2
            ),

            #' Slightly Negative Weighting
            src$radioInput(
                name = id,
                label = "Tend to avoid",
                value = -1
            ),

            #' Neutral (default checked)
            #' Requires a small value to avoid nulls
            src$radioInput(
                    name = id,
                    label = "No Preference",
                    value = 0.1,
                    checked = TRUE
            ),

            #' Slightly Positive Weighting
            src$radioInput(
                name = id,
                label = "Tend to visit",
                value = 1
            ),

            #' Strongest Positive Weighting
            src$radioInput(
                name = id,
                label = "Essential",
                value = 2
            )
        )
    }

    # return ui
    src$main(
        # hero
        src$hero(
            id = "hero-finder",
            is_small = TRUE,
            tags$img(
                class = "illustration size-small airplane",
                src = "images/airplane-illustration.svg"
            ),
            tags$h1("Finder"),
            tags$h2("Get Travel Recommendations")
        ),

        #' //////////////////////////////////////
        # Introduction and Form
        src$section(
            class = "section-finder-intro",
            tags$h2("Plan a Holiday"),
            tags$p(
                "Let's figure out where you may want to visit. Rate how",
                "important it is to visit cafes with speciality coffee,",
                "craft breweries, and museums when on holiday.",
                "By default, all options are set to", tags$em("No Preference"),
                ", which can be used if you find a place",
                "neither important or unimportant. Press submit when you",
                "have made all of your decisions.",
            ),
            tags$form(
                id = "travel-form",
                class = "form",
                `aria-describedby` = "travel-form-title",

                #' Form Error
                tags$span(
                    id = "travel-form-error",
                    class = "error visually-hidden"
                ),

                #' Form  title
                tags$h3(
                    id = "travel-form-title",
                    class = "form-title",
                    "When on holiday, how important is it that you visit",
                    "..."
                ),

                #' //////////////////////////////////////
                # coffee
                src$radioInputGroup(
                    id = "coffeePrefs",
                    class = "radios coffee-radio",
                    tags$legend(
                        class = "radios-title",
                        "Cafes with Specialty Coffee?"
                    ),
                    user_prefs_ui(id = "coffeePrefs")
                ),
                # breweries
                src$radioInputGroup(
                    id = "breweryPrefs",
                    class = "radios brewery-radio",
                    tags$legend(class = "radios-title", "Breweries?"),
                    user_prefs_ui(id = "breweryPrefs")
                ),
                # musuems
                src$radioInputGroup(
                    id = "museumPrefs",
                    class = "radios musem-radio",
                    tags$legend(class = "radios-title", "Museums?"),
                    user_prefs_ui(id = "museumPrefs")
                ),

                #'//////////////////////////////////////

                #' Additional Options
                tags$h3("Additional Options"),

                #' Limit Results to Specific Countries
                src$accordion(
                    id = "countries_fieldset",
                    heading = "Limit Results to Specific Countries",
                    tags$p(
                        "Do you have a few countries that you would like to",
                        "visit in mind? Select the countries you would like",
                        "to search for destinations. Leave everything blank",
                        "if you would like to search everything."
                    ),
                    src$checkBoxGroup(
                        id = "countryFilter",
                        class = "checkboxes",
                        country_filter()
                    )
                ),

                # input to limit results
                src$accordion(
                    id = "limits_fieldset",
                    heading = "Exclude Top Cities",
                    tags$p(
                    "You can exclude any number of the cities with",
                    "them most places from the results. Larger cities",
                    "are likely to be recommended more as there are",
                    "more places to visit. You can remove any number of",
                    "the largest cities from the results. For example,",
                    "entering '3' will remove the top three cities. '4' will",
                    "remove the top four cities and so on. Entering '0' will",
                    "keep all cities. See the data tab for a complete list of",
                    "cities."
                    ),
                    tags$fieldset(
                        class = "number-input-group",
                        tags$label(
                            `for` = "limitResults",
                            class = "number-input-label",
                            "Enter the number of top cities you would like to",
                            "remove."
                        ),
                        tags$input(
                            id = "option_city_limits",
                            type = "number",
                            class = "number-input",
                            value = 0,
                            max = 50,
                            min = 0
                        ),
                        tags$span(
                            id = "limit-results-error",
                            class = "error visually-hidden"
                        )
                    )
                ),
                # Form buttons
                tags$div(
                    class = "b-list",
                    tags$button(
                        id = "resetTravelForm",
                        class = "action-button shiny-bound-input b b-secondary",
                        "Reset"
                    ),
                    tags$button(
                        id = "submitTravelForm",
                        class = "action-button shiny-bound-input b b-primary",
                        "Submit"
                    )
                )
            )
        ),
        #'//////////////////////////////////////
        #' ~ 2 ~
        #' Build Report
        tags$article(
            id = "travel-summary",
            class = "article visually-hidden",
            class = "article",
            `aria-hidden` = "true",

            # section maps
            src$section(
                tags$h2("Recommended Cities"),
                tags$p("Based on your selections, here are your results."),
                tags$figcaption(
                    id = "recommended-cities-caption",
                    class = "visually-hidden"
                ),
                tags$figure(
                    id = "recommended-cities",
                    `aria-describedby` = "recommended-cities-caption",
                    class = "d3-viz-output top-n-maps",
                )
            )
        ),

        # Call JavaScript Functions
        tags$script("setTimeout(function() { accordions.addToggles()}, 375);")
    )
}