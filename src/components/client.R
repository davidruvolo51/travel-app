#' ////////////////////////////////////////////////////////////////////////////
#' FILE: client.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-13
#' MODIFIED: 2020-02-27
#' PURPOSE: list of ui components
#' STATUS: in.progress
#' PACKAGES: shiny; htmltools
#' COMMENTS: NA
#' ////////////////////////////////////////////////////////////////////////////

#' pkgs
#' if (!require("shiny")) {
#'     suppressPackageStartupMessages(library(shiny))
#' }

#' Define components object
#' The object `src` will receive all components that will be used in the
#' client (i.e., navlist, buttons, etc.).
src <- list()

#'//////////////////////////////////////

#' ~ a ~
#' Navigation Components

src$nav <- list()

#' ~ i ~
#' - id: a string containing a unique id for the output element (i.e., menu)
#' - class: a string containing one or more classnames for the output element
#' - links: an array of urls
#' - labels: an array of labels for the url (i.e., text to be displayed)
src$nav$navlinks <- function(id = NULL, class = NULL, links, labels) {
    # build menu
    menu <- tags$ul(class = "menu")
    items <- list()
    sapply(seq_len(length(links)), function(link) {
        item <- tags$li(class = "menu-item")
        # define href and text
        if (length(labels[link]) > 0) {
            item$children <- tags$a(
                class = "shiny-bound-input menu-link",
                href = links[link],
                id = tolower(links[link]),
                `data-tab` = tolower(links[link]),
                labels[link]
            )
        }
        # if missing labels, print url instead of text
        if (link > length(labels)) {
            item$children <- tags$a(
                class = "menu-link",
                href = links[link],
                links[link]
            )
        }
        # append to master object
        items[[link]] <<- item
    })
    # append id
    if (length(id) > 0) {
        menu$attribs$id <- id
    }
    # append class
    if (length(class) > 0) {
        menu$attribs$class <- paste0(menu$attribs$class, " ", class)
    }
    # append children
    menu$children <- items
    return(menu)
}


#' ~ ii ~
#' Define navigation bar toggle
src$nav$toggle <- function(class = NULL) {
    t <- tags$button(
            id = "toggle",
            `aria-expanded` = "false",
            `aria-describedby` = "toggle-label",
            class = "btn btn-icon action-button shiny-bound-input",
            tagList(
                tags$span(
                    id = "toggle-label",
                    class = "visually-hidden",
                    "open and close menu"
                ),
                tags$span(class = "menu-icon", `aria-hidden` = "true",
                    tags$span(class = "menu-bar"),
                    tags$span(class = "menu-bar"),
                    tags$span(class = "menu-bar")
                )
            )
        )
    if (length(class) > 0) {
        t$attribs$class <- paste0(t$attribs$class, " ", class)
    }
    return(t)
}

#' ~ iii ~
#' Define the complete navigation element
src$navbar <- function(title, links, labels) {
    n <- tags$nav(class = "nav", role = "navigation",
        tags$h1(class = "nav-item nav-title",
            tags$a(href = "/", class = "nav-item brand-link", title)
        ),
        src$nav$navlinks(
            id = "navlinks",
            class = "nav-item",
            links = links,
            labels = labels
        ),
        tags$div(class = "nav-item menu-btn",
            src$nav$toggle(class = "nav-item")
        )
    )
    return(n)
}

#'//////////////////////////////////////

#' ~ b ~
#' Define Page Areas

#' ~ i ~
#' Alternative to <main>
#' - class: a string containing one or more class class names
#' - ...: child elements to render inside the <main> element
src$main <- function(..., class = NULL, extra_spacing = TRUE) {
    m <- tags$main(id = "main", class = "main", ...)
    if (length(class) > 0) {
        m$attribs$class <- paste0(m$attribs$class, " ", class)
    }
    if (isTRUE(extra_spacing)) {
        m$attribs$class <- paste0(
            m$attribs$class, " ",
            "main-extra-top-spacing"
        )
    }
    return(m)
}

#' ~ ii ~
#' custom <section>
#' - id: a string containing a unique id for the section
#' - class: a string containing one or more class class names
#' - ...: child elements to render inside the <section> element
src$section <- function(..., id = NULL, class = NULL, title = NULL) {
    s <- tags$section(class = "section", ...)
    if (length(title) > 0) {
        # extract title
        t <- gsub("[[:space:]]", "-", tolower(title))
        s$attribs$`aria-describedby` <- t
        s$children <- tagList(
            tags$h2(id = t, title),
            ...
        )
    }
    if (length(id) > 0) s$attribs$id <- id;
    if (length(class) > 0) {
        s$attribs$class <- paste0(s$attribs$class, " ", class)
    }
    return(s)
}


#' ~ iii ~
#' <App />
src$app <- function(...) {
    app <- tagList(
        tags$a(
            href = "main",
            class = "visually-hidden",
            "skip to main content"
        ),
        ...
    )
    return(app)
}


#' ~ iv ~
#' <Hero />
src$hero <- function(..., id = NULL, class = NULL, is_small = FALSE) {
    h <- tags$header(
        class = "hero ",
        tags$div(..., class = "hero-content"),
        tags$div(class = "hero-filter", `aria-hidden` = "true")
    )
    # add id
    if (length(id) > 0) h$attribs$id <- id

    # add css based on props
    if (length(class) > 0) {
        h$attribs$class <- paste0(css, " ", class)
    }
    # update css based on props
    if (isTRUE(is_small)) {
        h$attribs$class <- paste0(h$attribs$class, "hero-small")
    } else {
        h$attribs$class <- paste0(h$attribs$class, "hero-normal")
    }
    return(h)
}

#' ~ v ~
#' <Footer />
src$footer <- function(..., id = NULL, class = NULL) {
    f <- tags$footer(
        class = "footer",
        tags$div(class = "footer-content",
            ...
        )
    )
    if (length(id) > 0) f$attribs$id <- id;
    if (length(class) > 0) {
        f$attribs$class <- paste0(f$attribs$class, " ", class)
    }
    return(f)
}

#'////////////////////////////////////////////////////////////////////////////

#' ~ 2 ~
#' Define list of functions for inputs

#' ~ a ~
#' radio input group
src$radioInputGroup <- function(..., id, class = NULL) {
    f <- tags$fieldset(
        class = "shiny-input-radiogroup",
        role = "radiogroup",
        ...
    )
    if (length(id) > 0) f$attribs$id <- id;
    if (length(class) > 0) {
        f$attribs$class <- paste0(f$attribs$class, " ", class)
    }
    return(f)
}


#' ~ b ~
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


#' ~ c ~
#' checkbox group
src$checkBoxGroup <- function(..., id = NULL, class = NULL) {
    f <- tags$fieldset(
        class = "shiny-input-checkboxgroup",
        role = "checkboxgroup",
        ...
    )
    if (length(id) > 0) f$attribs$id <- id
    if (length(class) > 0) {
        f$attribs$class <- paste0(f$attribs$class, " ", class)
    }
    return(f)
}

#' ~ d ~
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

#'////////////////////////////////////////////////////////////////////////////

#' ~ 3 ~
#' UI Components


#' ~ a ~
#' Collapsible Section
src$accordion <- function(..., id, heading, text = NULL) {

    #' define internal IDs
    btnID <- paste0("accordion_", id)
    sectionID <- paste0("accordion_section_",btnID)

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
