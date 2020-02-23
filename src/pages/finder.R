#' ////////////////////////////////////////////////////////////////////////////
#' FILE: finder.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-02-18
#' PURPOSE: ui page component for finder tab
#' STATUS: in.progress
#' PACKAGES: NA
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
        # selection section
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
                tags$h3(
                    id = "travel-form-title",
                    class = "form-title visually-hidden",
                    "Rate each place type by how important it is to you"
                ),

                #' //////////////////////////////////////
                # coffee
                src$radioInputGroup(
                    id = "coffeePrefs",
                    class = "radios coffee-radio",

                    # title
                    tags$legend(
                        class = "radios-title",
                        "How important is",
                        tags$strong(
                            class = "radio-title-emph",
                            "coffee"
                        )
                    ),
                    # buttons
                    src$radioInput(
                        name = "coffeePrefs",
                        label = "No Preference",
                        checked = TRUE
                    ),
                    src$radioInput(name = "coffeePrefs", label = "Not at all"),
                    src$radioInput(name = "coffeePrefs", label = "Somewhat"),
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
                        "How important are",
                        tags$strong(
                            class = "radio-title-emph",
                            "breweries"
                        )
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
                        "How important are",
                        tags$strong(
                            class = "radio-title-emph",
                            "museums"
                        )
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
        )
    )
}