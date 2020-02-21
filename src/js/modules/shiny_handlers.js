////////////////////////////////////////////////////////////////////////////////
// FILE: shiny_handlers.js
// AUTHOR: David Ruvolo
// CREATED: 2020-02-21
// MODIFIED: 2020-02-21
// PURPOSE: custom handlers for shiny
// DEPENDENCIES: parceljs, babeljs
// STATUS: working;
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// LOG SOMETHING TO THE CONSOLE
export function console_log(value, asDir) {
    if (asDir) {
        console.dir(value);
    } else {
        console.log(value);
    }
}

////////////////////////////////////////

// CSS export functions

// REMOVE CSS CLASS
export function remove_css(elem, css) {
    const elems = document.querySelectorAll(elem);
    elems.forEach(e => e.classList.remove(css))
}

// TOGGLE CSS CLASS
export function toggle_css(elem, css) {
    const elems = document.querySelectorAll(elem);
    elems.forEach(e => e.classList.toggle(css))
}

export function add_css(elem, css) {
    const elems = document.querySelectorAll(elem);
    elems.forEach(e => e.classList.add(css))
}


////////////////////////////////////////

// Modifying the Document Body

// SET INNERHTML
export function inner_html(elem, string, delay) {
    if (delay) {
        setTimeout(export function () {
            document.querySelector(elem).innerHTML = string;
        }, delay)
    } else {
        document.querySelector(elem).innerHTML = string;
    }
}

////////////////////////////////////////

// Modifying ELement Attributes

// Set element attribs
export function set_element_attribute(elem, attr, value) {
    document.querySelector(elem).setAttribute(attr, value);
}


// remove element attribs
export function remove_element_attribute(elem, attr) {
    document.querySelector(elem).removeAttribute(attr);
}

////////////////////////////////////////

// SHOW ELEM (SHOW / HIDE)
export function show_elem(elem, css) {
    const el = document.querySelector(elem);
    if (css.length > 0) {
        el.classList.remove(css);
    } else {
        el.classList.remove("hidden");
    }
    el.removeAttribute("hidden");
}

// HIDE ELEM
export function hide_elem(elem, css) {
    const el = document.querySelector(elem);
    if (css.length > 0) {
        el.classList.add(css)
    } else {
        el.classList.add("hidden");
    }
    el.setAttribute("hidden", true);
}

// Remove Element from document
export function remove_elem(elem) {
    const el = document.querySelector(elem);
    el.parentNode.removeChild(el);
}

////////////////////////////////////////

// Inputs
export function clear_input(elem, value) {
    const inputs = document.querySelectorAll(elem);
    inputs.forEach(input => {
        if (value.length > 0) {
            input.value = value
        } else {
            input.value = ""
        }
    });
}

////////////////////////////////////////

// Window Behaviors
// REFRESH PAGE
export function refresh_page(value) {
    history.go(0);
}

// SCROLL TO TOP OF PAGE
export function scroll_to_top(value) {
    window.scrollTo(0, 0);
}