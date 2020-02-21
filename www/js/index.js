////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-02-14
// MODIFIED: 2020-02-14
// PURPOSE: primary functions for application
// DEPENDENCIES: NA
// STATUS: in.progress
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// Define Shiny Handlers
utils = (function () {

    // ADD CSS CLASS
    function add_css(elem, css) {
        const elems = document.querySelectorAll(elem);
        elems.forEach(e => e.classList.add(css))
    }

    // CLEAR INPUTS
    function clear_input(elem, value) {
        const inputs = document.querySelectorAll(elem);
        inputs.forEach(input => {
            if (value.length > 0) {
                input.value = value
            } else {
                input.value = ""
            }
        });
    }

    // LOG SOMETHING TO THE CONSOLE
    function console_log(value, asDir) {
        if (asDir) {
            console.dir(value);
        } else {
            console.log(value);
        }
    }

    // REMOVE CSS CLASS
    function remove_css(elem, css) {
        const elems = document.querySelectorAll(elem);
        elems.forEach(e => e.classList.remove(css))
    }

    // TOGGLE CSS CLASS
    function toggle_css(elem, css) {
        const elems = document.querySelectorAll(elem);
        elems.forEach(e => e.classList.toggle(css))
    }

    // SET INNERHTML
    function inner_html(elem, string, delay) {
        if (delay) {
            setTimeout(function () {
                document.querySelector(elem).innerHTML = string;
            }, delay)
        } else {
            document.querySelector(elem).innerHTML = string;
        }
    }

    // SET ELEMENT ATTRIBUTES
    function set_element_attribute(elem, attr, value) {
        document.querySelector(elem).setAttribute(attr, value);
    }

    // REFRESH PAGE
    function refresh_page(value) {
        history.go(0);
    }

    // SCROLL TO TOP OF PAGE
    function scroll_to_top(value) {
        window.scrollTo(0, 0);
    }

    ////////////////////////////////////////

    // SHOW ELEM (SHOW / HIDE)
    function show_elem(elem, css) {
        const el = document.querySelector(elem);
        if (css.length > 0) {
            el.classList.remove(css);
        } else {
            el.classList.remove("hidden");
        }
        el.removeAttribute("hidden");
    }

    // HIDE ELEM
    function hide_elem(elem, css) {
        const el = document.querySelector(elem);
        if (css.length > 0) {
            el.classList.add(css)
        } else {
            el.classList.add("hidden");
        }
        el.setAttribute("hidden", true);
    }

    function remove_elem(elem) {
        const el = document.querySelector(elem);
        el.parentNode.removeChild(el);
    }

    ////////////////////////////////////////
    // Return functions
    return {
        add_css: add_css,
        clear_input: clear_input,
        console_log: console_log,
        hide_elem: hide_elem,
        inner_html: inner_html,
        refresh_page: refresh_page,
        remove_css: remove_css,
        remove_elem: remove_elem,
        set_element_attribute: set_element_attribute,
        scroll_to_top: scroll_to_top,
        show_elem: show_elem,
        toggle_css: toggle_css
    }
})();


////////////////////////////////////////
// register modals
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