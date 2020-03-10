#' ////////////////////////////////////////////////////////////////////////////
#' FILE: search.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-03-10
#' PURPOSE: ui page component for search tab
#' STATUS: working
#' PACKAGES: shiny; custom handlers; sass; babel; D3
#' COMMENTS: load page in server and use reactiveVal "current_page" to render
#'           pages dynamically (application routing)
#' ////////////////////////////////////////////////////////////////////////////
search_page <- function() {

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
    tags$main(
        id = "search-main",
        class = "main main-extra-top-spacing",

        # hero
        tags$header(
            id = "hero-finder",
            class = "hero hero-small",
            tags$div(class = "hero-content",
                tags$img(
                    class = "illustration size-small airplane",
                    src = "images/airplane-illustration.svg"
                ),
                tags$h1("Finder"),
                tags$h2("Get Travel Recommendations")
            )
        ),

        #' //////////////////////////////////////
        # Introduction and Form
        tags$section(
            class = "section",
            id = "section-finder-intro",
            tags$h2("Plan your next holiday"),
            tags$p(
                "Let's figure out where to go. Rate how",
                "important it is to visit cafes with",
                tags$a(
                    href = "https://sca.coffee/research/what-is-specialty-coffee",
                    "speciality coffee,"
                ),
                "breweries, and museums when visiting a new city."
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
                tags$fieldset(
                    id = "coffeePrefs",
                    class = "shiny-input-radiogroup radios coffee-radio",
                    role = "radio-group",
                    tags$legend(
                        class = "radios-title",
                        "Cafes with Specialty Coffee?"
                    ),
                    user_prefs_ui(id = "coffeePrefs")
                ),
                # breweries
                tags$fieldset(
                    id = "breweryPrefs",
                    class = "shiny-input-radiogroup radios brewery-radio",
                    role = "radio-group",
                    tags$legend(class = "radios-title", "Breweries?"),
                    user_prefs_ui(id = "breweryPrefs")
                ),
                # musuems
                tags$fieldset(
                    id = "museumPrefs",
                    class = "shiny-input-radiogroup radios musem-radio",
                    role = "radio-group",
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
                        "Do you have a country in mind or would you like",
                        "to search a few countries at once? Select the",
                        "countries that you would like to visit."
                    ),
                    tags$fieldset(
                        id = "country_limits",
                        class = "shiny-input-checkboxgroup checkboxes",
                        role = "checkboxgroup",
                        src$country_filter(id = "country_limits")
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
                    "more places to visit.",
                    "See the data tab for a complete list of cities"
                    ),
                    tags$fieldset(
                        class = "number-input-group",
                        tags$label(
                            `for` = "option_city_limits",
                            class = "number-input-label",
                            "Enter the number of top cities (up to 50) that",
                            "you would like to remove."
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
            tags$section(
                class = "section",
                tags$h2("Recommended Cities"),
                tags$p(id = "recommended-cities-summary"),
                tags$figcaption(
                    id = "recommended-cities-caption",
                    class = "visually-hidden"
                ),
                tags$section(
                    id = "recommended-cities",
                    `aria-describedby` = "recommended-cities-caption",
                    class = "d3-viz-output",
                )
            ),

            # summary charts
            tags$section(
                id = "summary-of-recommended-cities",
                class = "section",
                tags$h2("Summary of Recommended Cities"),
                tags$p(
                    "The following table displays the number of places",
                    "and score for the recommended cities."
                )
            ),
            # wrap up
            tags$section(class = "section",
                tags$h2("About the Results"),
                tags$p(
                    "All cities were scored using a weight mean where the",
                    "weights are your preference for visting each place.",
                    "Cities with higher scores are more likely to be a better",
                    "destinations then cities with lower scores.",
                    "Larger cities are likely to be recommended more often as",
                    "these cities have more places. Use the additional",
                    "options to customize your search."
                )
            )
        ),

        # Call JavaScript Functions
        tags$script("setTimeout(function() { accordions.addToggles()}, 375);")
    )
}