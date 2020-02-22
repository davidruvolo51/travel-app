////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-02-14
// MODIFIED: 2020-02-21
// PURPOSE: primary functions for application
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// imports
import * as utils from "./modules/shiny_handlers"

////////////////////////////////////////
// register shiny modules
Shiny.addCustomMessageHandler("add_css", function (value) {
    utils.add_css(value[0], value[1]);
});

Shiny.addCustomMessageHandler("clear_input", function (value) {
    utils.clear_input(value)
})

Shiny.addCustomMessageHandler("console_log", function (value) {
    utils.console_log(value[0], value[1]);
});

Shiny.addCustomMessageHandler("hide_elem", function (value) {
    utils.hide_elem(value[0], value[1]);
});
Shiny.addCustomMessageHandler("inner_html", function (value) {
    utils.inner_html(value[0], value[1], value[2])
});

Shiny.addCustomMessageHandler("refresh_page", function (value) {
    utils.refresh_page(value);
});

Shiny.addCustomMessageHandler("remove_css", function (value) {
    utils.remove_css(value[0], value[1]);
});

Shiny.addCustomMessageHandler("remove_elem", function(value) {
    utils.remove_elem(value)
})

Shiny.addCustomMessageHandler("remove_element_attribute", function (value) {
    utils.remove_element_attribute(value[0], value[1]);
});

Shiny.addCustomMessageHandler("set_element_attribute", function (value) {
    utils.set_element_attribute(value[0], value[1], value[2]);
});

Shiny.addCustomMessageHandler("scroll_to_top", function (value) {
    utils.scroll_to_top(value);
})

Shiny.addCustomMessageHandler("show_elem", function (value) {
    utils.show_elem(value[0], value[1]);
});

Shiny.addCustomMessageHandler("toggle_css", function (value) {
    utils.toggle_css(value[0], value[1]);
});

// Function for handling clicks of all navigation links 
(function () {
    // select all navigation links
    const home = document.getElementById("home");
    const finder = document.getElementById("finder");
    const explorer = document.getElementById("explorer");

    /// add event listeners
    home.addEventListener("click", function(event) { 
        event.preventDefault();
        Shiny.setInputValue("home", "home", {priority: "event"});
        document.title = "shinyTravel | home"
    });
    finder.addEventListener("click", function(event) {
        event.preventDefault();
        Shiny.setInputValue("finder", "finder", {priority: "event"});
        document.title = "shinyTravel | Finder"
    });
    explorer.addEventListener("click", function(event) {
        event.preventDefault();
        Shiny.setInputValue("explorer", "explorer", {priority: "event"});
        document.title = "shinyTravel | Explorer"
    })
})();


// Anonymous function for handling menu toggle
(function () {

    // pull all elements
    const menuToggle = document.getElementById("toggle");
    const menu = document.getElementById("navlinks");
    const body = document.querySelector("body");
    const width = body.getBoundingClientRect().width;

    // init menu state
    menu.addEventListener("DOMContentLoaded", function () {
        if (width > 912) {
            menu.setAttribute("hidden", "false");
        }
        if (width <= 912) {
            menu.setAttribute("hidden", "true");
        }
    })

    // bind to menu togle <button id="toggle">
    menuToggle.addEventListener("click", function () {
        menu.classList.toggle("expanded");
        menuToggle.classList.toggle("open");
        if (menuToggle.getAttribute("aria-expanded") === false) {
            menuToggle.setAttribute("aria-expaned", "true");
            menu.removeAttribute("hidden");
        }
        if (menuToggle.getAttribute("aria-expanded") === true) {
            menuToggle.setAttribute("aria-expanded", "false");
            menu.setAttribute("hidden", "true");
        }
    });

    // handle menu action when window is resized
    menu.addEventListener("resize", function () {
        let w = body.getBoundingClientRect().width;
        if (w > 912) {
            menu.classList.remove("expanded");
            menu.removeAttribute("hidden");
            menuToggle.classList.remove("open");
            menuToggle.setAttribute("aria-expanded", "false");
        }
    });
})();