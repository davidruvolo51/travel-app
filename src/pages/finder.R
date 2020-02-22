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
                tags$fieldset(
                    class = "input-group radios coffee-radio",
                    tags$legend(
                        class = "radios-title",
                        "How important is",
                        tags$strong(
                            class = "radio-title-emph",
                            "coffee"
                        )
                    ),

                    # button: none
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "coffee-none",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "coffee",
                            value = 0
                        ),
                        tags$label(
                            `for` = "coffee-none",
                            class = "radio-label",
                            "Not at all"
                        )
                    ),

                    # button: a little
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "coffee-little",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "coffee",
                            value = 1
                        ),
                        tags$label(
                            `for` = "coffee-little",
                            class = "radio-label",
                            "A little"
                        )
                    ),

                    # button: important
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "coffee-somewhat",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "coffee",
                            value = 2
                        ),
                        tags$label(
                            `for` = "coffee-somewhat",
                            class = "radio-label",
                            "Somewhat"
                        )
                    ),

                    # button: very important
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "coffee-very",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "coffee",
                            value = 3
                        ),
                        tags$label(
                            `for` = "coffee-very",
                            class = "radio-label",
                            "Very"
                        )
                    ),

                    # button: essential
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "coffee-essential",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "coffee",
                            value = 4
                        ),
                        tags$label(
                            `for` = "coffee-essential",
                            class = "radio-label",
                            "Essential"
                        )
                    )
                ),

                #' //////////////////////////////////////
                # breweries
                tags$fieldset(
                    class = "input-group radios brewery-radio",
                    tags$legend(
                        class = "radios-title",
                        "How important are",
                        tags$strong(
                            class = "radio-title-emph",
                            "breweries"
                        )
                    ),
                    # button: none
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "breweries-none",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "breweries",
                            value = 0
                        ),
                        tags$label(
                            `for` = "breweries-none",
                            class = "radio-label",
                            "Not at all"
                        )
                    ),

                    # button: a little
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "breweries-little",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "breweries",
                            value = 1
                        ),
                        tags$label(
                            `for` = "breweries-little",
                            class = "radio-label",
                            "A little"
                        )
                    ),

                    # button: important
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "breweries-somewhat",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "breweries",
                            value = 2
                        ),
                        tags$label(
                            `for` = "breweries-somewhat",
                            class = "radio-label",
                            "Somewhat"
                        )
                    ),

                    # button: very important
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "breweries-very",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "breweries",
                            value = 3
                        ),
                        tags$label(
                            `for` = "breweries-very",
                            class = "radio-label",
                            "Very"
                        )
                    ),

                    # button: essential
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "breweries-essential",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "breweries",
                            value = 4
                        ),
                        tags$label(
                            `for` = "breweries-essential",
                            class = "radio-label",
                            "Essential"
                        )
                    )
                ),

                #' //////////////////////////////////////
                # musuems
                tags$fieldset(
                    class = "input-group radios musem-radio",
                    tags$legend(
                        class = "radios-title",
                        "How important are",
                        tags$strong(
                            class = "radio-title-emph",
                            "museums"
                        )
                    ),

                    # button: none
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "museums-none",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "museums",
                            value = 0
                        ),
                        tags$label(
                            `for` = "museums-none",
                            class = "radio-label",
                            "Not at all"
                        )
                    ),

                    # button: a little
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "museums-little",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "museums",
                            value = 1
                        ),
                        tags$label(
                            `for` = "museums-little",
                            class = "radio-label",
                            "A little"
                        )
                    ),

                    # button: important
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "museums-somewhat",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "museums",
                            value = 2
                        ),
                        tags$label(
                            `for` = "museums-somewhat",
                            class = "radio-label",
                            "Somewhat"
                        )
                    ),

                    # button: very important
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "museums-very",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "museums",
                            value = 3
                        ),
                        tags$label(
                            `for` = "museums-very",
                            class = "radio-label",
                            "Very"
                        )
                    ),

                    # button: essential
                    tags$div(
                        class = "radio-btn",
                        tags$input(
                            id = "museums-essential",
                            class = "radio-input",
                            type = "radio",
                            role = "radio",
                            name = "museums",
                            value = 4
                        ),
                        tags$label(
                            `for` = "museums-essential",
                            class = "radio-label",
                            "Essential"
                        )
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