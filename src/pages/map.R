#'////////////////////////////////////////////////////////////////////////////
#' FILE: map.R
#' AUTHOR: David Ruvolo
#' CREATED: 2020-02-18
#' MODIFIED: 2020-03-10
#' PURPOSE: ui page component for explorer page
#' STATUS: working
#' PACKAGES: shiny; mapbox
#' COMMENTS: import page in server and use the reactiveVal "current_page" to
#'           dynamically render map page; icons from MAKI icons
#'////////////////////////////////////////////////////////////////////////////
map_page <- function() {
    tags$main(
        id = "map-main",
        class = "main main-extra-top-spacing",
        tags$header(
            class = "hero hero-small",
            tags$div(
                class = "hero-content",
                tags$img(
                    class = "illustration size-small ticket",
                    src = "images/ticket-illustration.svg"
                ),
                tags$h1("Map"),
                tags$h2("Explore the Data")
            )
        ),
        tags$section(
            class = "section",
            tags$h2("Plan your trip using a map"),
            tags$p(
                "View all cities and locations using the map below.",
                "Zoom in and tap on a location to view more information",
                "about that place. The legend for the location types",
                "is presented below."
            ),
            tags$ul(
                id = "places",
                class = "legend",
                tags$li(
                    class = "legend-item breweries",
                    `data-type` = "breweries",
                    HTML('<svg version="1.1" id="beer-15" xmlns="http://www.w3.org/2000/svg" width="15px" height="15px" viewBox="0 0 15 15"><path d="M12,5V2c0,0-1-1-4.5-1S3,2,3,2v3c0.0288,1.3915,0.3706,2.7586,1,4c0.6255,1.4348,0.6255,3.0652,0,4.5c0,0,0,1,3.5,1&#xA;&#x9;s3.5-1,3.5-1c-0.6255-1.4348-0.6255-3.0652,0-4.5C11.6294,7.7586,11.9712,6.3915,12,5z M7.5,13.5&#xA;&#x9;c-0.7966,0.035-1.5937-0.0596-2.36-0.28c0.203-0.7224,0.304-1.4696,0.3-2.22h4.12c-0.004,0.7504,0.097,1.4976,0.3,2.22&#xA;&#x9;C9.0937,13.4404,8.2966,13.535,7.5,13.5z M7.5,5C6.3136,5.0299,5.1306,4.8609,4,4.5v-2C5.131,2.1411,6.3137,1.9722,7.5,2&#xA;&#x9;C8.6863,1.9722,9.869,2.1411,11,2.5v2C9.8694,4.8609,8.6864,5.0299,7.5,5z"/></svg>'),
                    tags$span("Brewery")
                ),
                tags$li(
                    class = "legend-item museums",
                    `data-type` = "museums",
                    HTML('<svg version="1.1" id="museum-15" xmlns="http://www.w3.org/2000/svg" width="15px" height="15px" viewBox="0 0 15 15"><path id="path7509" d="M7.5,0L1,3.4453V4h13V3.4453L7.5,0z M2,5v5l-1,1.5547V13h13v-1.4453L13,10&#xA;&#x9;V5H2z M4.6152,6c0.169-0.0023,0.3318,0.0639,0.4512,0.1836L7.5,8.6172l2.4336-2.4336c0.2445-0.2437,0.6402-0.2432,0.884,0.0013&#xA;&#x9;C10.9341,6.3017,10.9997,6.46,11,6.625v4.2422c0.0049,0.3452-0.271,0.629-0.6162,0.6338c-0.3452,0.0049-0.629-0.271-0.6338-0.6162&#xA;&#x9;c-0.0001-0.0059-0.0001-0.0118,0-0.0177V8.1328L7.9414,9.9414c-0.244,0.2433-0.6388,0.2433-0.8828,0L5.25,8.1328v2.7344&#xA;&#x9;c0.0049,0.3452-0.271,0.629-0.6162,0.6338C4.2887,11.5059,4.0049,11.2301,4,10.8849c-0.0001-0.0059-0.0001-0.0118,0-0.0177V6.625&#xA;&#x9;C4,6.2836,4.2739,6.0054,4.6152,6z"/></svg>'),
                    tags$span("Museum")
                ),
                tags$li(
                    class = "legend-item cafes",
                    `data-type` = "cafes",
                    HTML('<svg version="1.1" id="cafe-15" xmlns="http://www.w3.org/2000/svg" width="15px" height="15px" viewBox="0 0 15 15"><path d="M12,5h-2V3H2v4c0.0133,2.2091,1.8149,3.9891,4.024,3.9758C7.4345,10.9673,8.7362,10.2166,9.45,9H12c1.1046,0,2-0.8954,2-2&#xA;&#x9;S13.1046,5,12,5z M12,8H9.86C9.9487,7.6739,9.9958,7.3379,10,7V6h2c0.5523,0,1,0.4477,1,1S12.5523,8,12,8z M10,12.5&#xA;&#x9;c0,0.2761-0.2239,0.5-0.5,0.5h-7C2.2239,13,2,12.7761,2,12.5S2.2239,12,2.5,12h7C9.7761,12,10,12.2239,10,12.5z"/></svg>'),
                    tags$span("Cafe")
                )
            )
        ),
        tags$div(id = "travelMap", class = "map-panel"),
        tags$script(
            "setTimeout(function() { map.render_mapbox('travelMap') }, 600)"
        )
    )
}