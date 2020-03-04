#' ////////////////////////////////////////////////////////////////////////////
#' FILE: client.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-03-04
#' PURPOSE: list of ui components
#' STATUS: in.progress
#' PACKAGES: shiny; htmltools
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

#' Define components object
src <- list()

#' radio input
src$radioInput <- function(name, label, value, checked = FALSE) {
    id <- paste0(name, "-", gsub("[[:space:]]", "-", tolower(label)))
    lab <- tags$label(`for` = id, class =  "radio-label", label)
    btn <- tags$input(
            id = id,
            type = "radio",
            role = "radio",
            name = name,
            value = value,
    )
    if (isTRUE(checked)) {
        btn$attribs$checked <- "true"
        btn$attribs$`data-default` <- "true"
    } else {
        btn$attribs$`data-default` <- "false"
    }
    return(tags$div(class = "radio-btn", btn, lab))
}

#' checkbox input
src$checkBoxInput <- function(name, label, value, checked = FALSE) {
    id <- paste0(name, "-", gsub("[[:space:]]", "-", tolower(label)))
    lab <- tags$label(`for` = id, class =  "checkbox-label", label)
    btn <- tags$input(
            id = id,
            type = "checkbox",
            role = "checkbox",
            name = name,
            value = value
    )
    if (isTRUE(checked)) {
        btn$attribs$checked <- "true"
        btn$attribs$`data-default` <- "true"
    } else {
        btn$attribs$`data-default` <- "false"
    }
    return(tags$div(class = "checkbox-btn", btn, lab))
}

#' Collapsible Section
src$accordion <- function(..., id, heading, text = NULL) {

    #' define internal IDs
    btnID <- paste0("accordion_", id)
    sectionID <- paste0("accordion_section_", btnID)

    #' Create heading with button and icon
    h <- tags$h4(
        class = "accordion-heading",
        tags$button(
            id = btnID,
            class = "accordion-button",
            `data-name` = id,
            `aria-controls` = "accordion-panel",
            `aria-expanded` = "false",
            heading,
            HTML(
                '<svg aria-hidden="true" class="accordion-icon" 
                    width="50" height="50" data-name=', id, '>
                    <g stroke="none" strokeWidth="1" fill="none">
                        <circle fill="#3F454B" cx="25" cy="25" r="24">
                        </circle>
                        <path d="M25,15 C26.1045695,15 27,15.8954305 27,17
                            L27,22.999 L33,23 C34.1045695,23 35,23.8954305
                            35,25 C35,26.1045695 34.1045695,27 33,27 L27,27
                            L27,33 C27,34.1045695 26.1045695,35 25,35
                            C23.8954305,35 23,34.1045695 23,33 L23,27
                            L17,27 C15.8954305,27 15,26.1045695 15,25
                            C15,23.8954305 15.8954305,23 17,23 L23,23
                            L23,17 C23,15.8954305 23.8954305,15
                            25,15 Z" fill="white"></path>
                    </g>
                </svg>'
            )
        )
    )

    #' Build Collapsible Section
    s <- tags$section(
        id = sectionID,
        class = "accordion-content visually-hidden",
        `aria-labelledby` = btnID,
        `data-name` = id,
        hidden = "",
        ...
    )

    #' Gather all elemenets
    a <- tagList(h, s)

    #'  return
    return(a)
}


#' Functional compontent for generating country filters
src$country_filter <- function(id) {
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