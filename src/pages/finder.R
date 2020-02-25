#' ////////////////////////////////////////////////////////////////////////////
#' FILE: finder.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-25
#' PURPOSE: ui page component for finder tab
#' STATUS: in.progress
#' PACKAGES: shiny; custom handlers; sass; babel; D3
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////
finder_tab <- function() {
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

                    # title
                    tags$legend(
                        class = "radios-title",
                        "Cafes with Specialty Coffee?",
                    ),
                    # buttons
                    src$radioInput(
                        name = "coffeePrefs",
                        label = "No Preference",
                        checked = TRUE
                    ),
                    src$radioInput(name = "coffeePrefs", label = "Not at all"),
                    src$radioInput(name = "coffeePrefs", label = "A little"),
                    src$radioInput(name = "coffeePrefs", label = "Important"),
                    src$radioInput(name = "coffeePrefs", label = "Very"),
                    src$radioInput(name = "coffeePrefs", label = "Essential")
                ),

                #' //////////////////////////////////////
                # breweries
                src$radioInputGroup(
                    id = "breweryPrefs",
                    class = "radios brewery-radio",

                    # title
                    tags$legend(
                        class = "radios-title",
                        "Breweries?"
                    ),

                    # buttons
                    src$radioInput(
                        name = "breweryPrefs",
                        label = "No Preference",
                        checked = TRUE
                    ),
                    src$radioInput(name = "breweryPrefs", label = "Not at all"),
                    src$radioInput(name = "breweryPrefs", label = "A little"),
                    src$radioInput(name = "breweryPrefs", label = "Important"),
                    src$radioInput(name = "breweryPrefs", label = "Very"),
                    src$radioInput(name = "breweryPrefs", label = "Essential")
                ),

                #' //////////////////////////////////////
                # musuems
                src$radioInputGroup(
                    id = "museumPrefs",
                    class = "radios musem-radio",

                    # title
                    tags$legend(
                        class = "radios-title",
                        "Museums?"
                    ),

                    # inputs
                    src$radioInput(
                        name = "museumPrefs",
                        label = "No Preference",
                        checked = TRUE
                    ),
                    src$radioInput(name = "museumPrefs", label = "Not at all"),
                    src$radioInput(name = "museumPrefs", label = "A little"),
                    src$radioInput(name = "museumPrefs", label = "Important"),
                    src$radioInput(name = "museumPrefs", label = "Very"),
                    src$radioInput(name = "museumPrefs", label = "Essential")
                ),

                #'//////////////////////////////////////
                # input to limit results
                tags$fieldset(
                    class = "number-input-group",
                    src$accordion(
                        id = "limitResultsDefs",
                        heading = "Would you like to limit the results?",
                        text = paste(
                        "You can exclude any number of the cities with",
                        "them most places from the results. See the data tab",
                        "for a complete list of cities. Enter a number between",
                        "0 and 50. A value of 50 will remove the top 50",
                        "cities whereas 0 will not exclude any cities.",
                        sep = " ")
                    ),
                    tags$label(
                        `for` = "limitResults",
                        class = "number-input-label",
                        "Enter the number of top cities you would like to",
                        "remove."
                    ),
                    tags$input(
                        id = "limitResults",
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
                ),

                # Form buttons
                tags$div(
                    class = "b-list",
                    tags$button(
                        id = "submitForm",
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
            # class = "article visually-hidden",
            class = "article",
            # `aria-hidden` = "true",

            # section maps
            src$section(
                tags$h2("Recommended Cities"),
                tags$p(
                    "Based on your selections, here are the top three",
                    "recommended cities. Scroll down to view why these",
                    "cities were recommended and more about them."
                ),
                tags$figcaption("Top 3 Cities"),
                tags$figure(
                    id = "recommended-cities",
                    class = "d3-viz-output top-n-maps",
                )
            )
        )
    )
}