// modules are defined as an array
// [ module function, map of requires ]
//
// map of requires is short require name -> numeric require
//
// anything defined in a previous bundle is accessed via the
// orig method which is the require for previous bundles
parcelRequire = (function (modules, cache, entry, globalName) {
  // Save the require from previous bundle to this closure if any
  var previousRequire = typeof parcelRequire === 'function' && parcelRequire;
  var nodeRequire = typeof require === 'function' && require;

  function newRequire(name, jumped) {
    if (!cache[name]) {
      if (!modules[name]) {
        // if we cannot find the module within our internal map or
        // cache jump to the current global require ie. the last bundle
        // that was added to the page.
        var currentRequire = typeof parcelRequire === 'function' && parcelRequire;
        if (!jumped && currentRequire) {
          return currentRequire(name, true);
        }

        // If there are other bundles on this page the require from the
        // previous one is saved to 'previousRequire'. Repeat this as
        // many times as there are bundles until the module is found or
        // we exhaust the require chain.
        if (previousRequire) {
          return previousRequire(name, true);
        }

        // Try the node require function if it exists.
        if (nodeRequire && typeof name === 'string') {
          return nodeRequire(name);
        }

        var err = new Error('Cannot find module \'' + name + '\'');
        err.code = 'MODULE_NOT_FOUND';
        throw err;
      }

      localRequire.resolve = resolve;
      localRequire.cache = {};

      var module = cache[name] = new newRequire.Module(name);

      modules[name][0].call(module.exports, localRequire, module, module.exports, this);
    }

    return cache[name].exports;

    function localRequire(x){
      return newRequire(localRequire.resolve(x));
    }

    function resolve(x){
      return modules[name][1][x] || x;
    }
  }

  function Module(moduleName) {
    this.id = moduleName;
    this.bundle = newRequire;
    this.exports = {};
  }

  newRequire.isParcelRequire = true;
  newRequire.Module = Module;
  newRequire.modules = modules;
  newRequire.cache = cache;
  newRequire.parent = previousRequire;
  newRequire.register = function (id, exports) {
    modules[id] = [function (require, module) {
      module.exports = exports;
    }, {}];
  };

  var error;
  for (var i = 0; i < entry.length; i++) {
    try {
      newRequire(entry[i]);
    } catch (e) {
      // Save first error but execute all entries
      if (!error) {
        error = e;
      }
    }
  }

  if (entry.length) {
    // Expose entry point to Node, AMD or browser globals
    // Based on https://github.com/ForbesLindesay/umd/blob/master/template.js
    var mainExports = newRequire(entry[entry.length - 1]);

    // CommonJS
    if (typeof exports === "object" && typeof module !== "undefined") {
      module.exports = mainExports;

    // RequireJS
    } else if (typeof define === "function" && define.amd) {
     define(function () {
       return mainExports;
     });

    // <script>
    } else if (globalName) {
      this[globalName] = mainExports;
    }
  }

  // Override the current require with this new one
  parcelRequire = newRequire;

  if (error) {
    // throw error from earlier, _after updating parcelRequire_
    throw error;
  }

  return newRequire;
})({"modules/shiny_handlers.js":[function(require,module,exports) {
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.console_log = console_log;
exports.remove_css = remove_css;
exports.toggle_css = toggle_css;
exports.add_css = add_css;
exports.inner_html = inner_html;
exports.set_element_attribute = set_element_attribute;
exports.remove_element_attribute = remove_element_attribute;
exports.show_elem = show_elem;
exports.hide_elem = hide_elem;
exports.remove_elem = remove_elem;
exports.clear_input = clear_input;
exports.refresh_page = refresh_page;
exports.scroll_to_top = scroll_to_top;

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
function console_log(value, asDir) {
  if (asDir) {
    console.dir(value);
  } else {
    console.log(value);
  }
} ////////////////////////////////////////
// CSS export functions
// REMOVE CSS CLASS


function remove_css(elem, css) {
  var elems = document.querySelectorAll(elem);
  elems.forEach(function (e) {
    return e.classList.remove(css);
  });
} // TOGGLE CSS CLASS


function toggle_css(elem, css) {
  var elems = document.querySelectorAll(elem);
  elems.forEach(function (e) {
    return e.classList.toggle(css);
  });
}

function add_css(elem, css) {
  var elems = document.querySelectorAll(elem);
  elems.forEach(function (e) {
    return e.classList.add(css);
  });
} ////////////////////////////////////////
// Modifying the Document Body
// SET INNERHTML


function inner_html(elem, string, delay) {
  if (delay) {
    setTimeout(function () {
      document.querySelector(elem).innerHTML = string;
    }, delay);
  } else {
    document.querySelector(elem).innerHTML = string;
  }
} ////////////////////////////////////////
// Modifying ELement Attributes
// Set element attribs


function set_element_attribute(elem, attr, value) {
  document.querySelector(elem).setAttribute(attr, value);
} // remove element attribs


function remove_element_attribute(elem, attr) {
  document.querySelector(elem).removeAttribute(attr);
} ////////////////////////////////////////
// SHOW ELEM (SHOW / HIDE)


function show_elem(elem, css) {
  var el = document.querySelector(elem);

  if (css.length > 0) {
    el.classList.remove(css);
  } else {
    el.classList.remove("hidden");
  }

  el.removeAttribute("hidden");
} // HIDE ELEM


function hide_elem(elem, css) {
  var el = document.querySelector(elem);

  if (css.length > 0) {
    el.classList.add(css);
  } else {
    el.classList.add("hidden");
  }

  el.setAttribute("hidden", true);
} // Remove Element from document


function remove_elem(elem) {
  var el = document.querySelector(elem);
  el.parentNode.removeChild(el);
} ////////////////////////////////////////
// Inputs


function clear_input(elem, value) {
  var inputs = document.querySelectorAll(elem);
  inputs.forEach(function (input) {
    if (value.length > 0) {
      input.value = value;
    } else {
      input.value = "";
    }
  });
} ////////////////////////////////////////
// Window Behaviors
// REFRESH PAGE


function refresh_page(value) {
  history.go(0);
} // SCROLL TO TOP OF PAGE


function scroll_to_top(value) {
  window.scrollTo(0, 0);
}
},{}],"index.js":[function(require,module,exports) {
"use strict";

var utils = _interopRequireWildcard(require("./modules/shiny_handlers"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } if (obj === null || typeof obj !== "object" && typeof obj !== "function") { return { default: obj }; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

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
////////////////////////////////////////
// register shiny modules
Shiny.addCustomMessageHandler("add_css", function (value) {
  utils.add_css(value[0], value[1]);
});
Shiny.addCustomMessageHandler("clear_input", function (value) {
  utils.clear_input(value);
});
Shiny.addCustomMessageHandler("console_log", function (value) {
  utils.console_log(value[0], value[1]);
});
Shiny.addCustomMessageHandler("hide_elem", function (value) {
  utils.hide_elem(value[0], value[1]);
});
Shiny.addCustomMessageHandler("inner_html", function (value) {
  utils.inner_html(value[0], value[1], value[2]);
});
Shiny.addCustomMessageHandler("refresh_page", function (value) {
  utils.refresh_page(value);
});
Shiny.addCustomMessageHandler("remove_css", function (value) {
  utils.remove_css(value[0], value[1]);
});
Shiny.addCustomMessageHandler("remove_elem", function (value) {
  utils.remove_elem(value);
});
Shiny.addCustomMessageHandler("remove_element_attribute", function (value) {
  utils.remove_element_attribute(value[0], value[1]);
});
Shiny.addCustomMessageHandler("set_element_attribute", function (value) {
  utils.set_element_attribute(value[0], value[1], value[2]);
});
Shiny.addCustomMessageHandler("scroll_to_top", function (value) {
  utils.scroll_to_top(value);
});
Shiny.addCustomMessageHandler("show_elem", function (value) {
  utils.show_elem(value[0], value[1]);
});
Shiny.addCustomMessageHandler("toggle_css", function (value) {
  utils.toggle_css(value[0], value[1]);
}); // Function for handling clicks of all navigation links 

(function () {
  // select all navigation links
  var home = document.getElementById("home");
  var finder = document.getElementById("finder");
  var explorer = document.getElementById("explorer"); /// add event listeners

  home.addEventListener("click", function (event) {
    event.preventDefault();
    Shiny.setInputValue("home", "home", {
      priority: "event"
    });
    document.title = "shinyTravel | home";
  });
  finder.addEventListener("click", function (event) {
    event.preventDefault();
    Shiny.setInputValue("finder", "finder", {
      priority: "event"
    });
    document.title = "shinyTravel | Finder";
  });
  explorer.addEventListener("click", function (event) {
    event.preventDefault();
    Shiny.setInputValue("explorer", "explorer", {
      priority: "event"
    });
    document.title = "shinyTravel | Explorer";
  });
})(); // Anonymous function for handling menu toggle


(function () {
  // pull all elements
  var menuToggle = document.getElementById("toggle");
  var menu = document.getElementById("navlinks");
  var body = document.querySelector("body");
  var width = body.getBoundingClientRect().width; // init menu state

  menu.addEventListener("DOMContentLoaded", function () {
    if (width > 912) {
      menu.setAttribute("hidden", "false");
    }

    if (width <= 912) {
      menu.setAttribute("hidden", "true");
    }
  }); // bind to menu togle <button id="toggle">

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
  }); // handle menu action when window is resized

  menu.addEventListener("resize", function () {
    var w = body.getBoundingClientRect().width;

    if (w > 912) {
      menu.classList.remove("expanded");
      menu.removeAttribute("hidden");
      menuToggle.classList.remove("open");
      menuToggle.setAttribute("aria-expanded", "false");
    }
  });
})();
},{"./modules/shiny_handlers":"modules/shiny_handlers.js"}]},{},["index.js"], null)