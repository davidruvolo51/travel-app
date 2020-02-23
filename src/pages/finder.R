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
                "craft breweries, and museums when on holiday. Select only",
                "one option for each place type."
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
                    tags$legend(
                        class = "radios-title",
                        "How important is",
                        tags$strong(
                            class = "radio-title-emph",
                            "coffee"
                        )
                    ),
                    # button:
                    src$radioInput(
                        name = "coffeePrefs",
                        label = "Not at all",
                        value = 0
                    ),

                    # button:
                    src$radioInput(
                        name = "coffeePrefs",
                        label = "Somewhat",
                        value = 1
                    ),


                    # button: important
                    src$radioInput(
                        name = "coffeePrefs",
                        label = "Important",
                        value = 2
                    ),

                    # button: very important
                    src$radioInput(
                        name = "coffeePrefs",
                        label = "Very",
                        value = 3
                    ),

                    # button: essential
                    src$radioInput(
                        name = "coffeePrefs",
                        label = "Essential",
                        value = 4
                    ),
                ),

                #' //////////////////////////////////////
                # breweries
                src$radioInputGroup(
                    id = "breweryPrefs",
                    class = "radios brewery-radio",
                    tags$legend(
                        class = "radios-title",
                        "How important are",
                        tags$strong(
                            class = "radio-title-emph",
                            "breweries"
                        )
                    ),
                    # button: none
                    src$radioInput(
                        name = "breweryPrefs",
                        label = "Not at all",
                        value = 0
                    ),

                    # button: a little
                    src$radioInput(
                        name = "breweryPrefs",
                        label = "A little",
                        value = 1
                    ),

                    # button: important
                    src$radioInput(
                        name = "breweryPrefs",
                        label = "Important",
                        value = 2
                    ),

                    # button: very important
                    src$radioInput(
                        name = "breweryPrefs",
                        label = "Very",
                        value = 3
                    ),

                    # button: essential
                    src$radioInput(
                        name = "breweryPrefs",
                        label = "Essential",
                        value = 4
                    )
                ),

                #' //////////////////////////////////////
                # musuems
                src$radioInputGroup(
                    id = "museumPrefs",
                    class = "radios musem-radio",
                    tags$legend(
                        class = "radios-title",
                        "How important are",
                        tags$strong(
                            class = "radio-title-emph",
                            "museums"
                        )
                    ),

                    # button: none
                    src$radioInput(
                        name = "museumPrefs",
                        label = "Not at all",
                        value = 0
                    ),

                    # button: a little
                    src$radioInput(
                        name = "museumPrefs",
                        label = "A little",
                        value = 1
                    ),

                    # button: important
                    src$radioInput(
                        name = "museumPrefs",
                        label = "Important",
                        value = 2
                    ),

                    # button: very important
                    src$radioInput(
                        name = "museumPrefs",
                        label = "Very",
                        value = 3
                    ),

                    # button: essential
                    src$radioInput(
                        name = "museumPrefs",
                        label = "Essential",
                        value = 4
                    )
                ),

                # Form buttons
                tags$div(
                    class = "b-list",
                    tags$button(
                        id = "resetForm",
                        class = "action-button shiny-bound-input b b-secondary",
                        "Reset"
                    ),
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