////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-02-14
// MODIFIED: 2020-02-24
// PURPOSE: primary functions for application
// DEPENDENCIES: NA
// STATUS: d3; topojson; countries geojson;
// COMMENTS: NA
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// ~ 1 ~
// define and register custom shiny handlers
(function () {

    // ADD CSS CLASS
    function add_css(elem, css) {
        const elems = document.querySelectorAll(elem);
        elems.forEach(e => e.classList.add(css))
    }

    // CLEAR INPUT VALUE
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

    // REFRESH PAGE
    function refresh_page(value) {
        history.go(0);
    }

    // REMOVE CSS CLASS
    function remove_css(elem, css) {
        const elems = document.querySelectorAll(elem);
        elems.forEach(e => e.classList.remove(css))
    }

    // REMOVE ELEMENT (from document)
    function remove_elem(elem) {
        const el = document.querySelector(elem);
        el.parentNode.removeChild(el);
    }

    // REMOVE ELEMENT ATTRIBUTE
    function remove_element_attribute(elem, attr) {
        document.querySelector(elem).removeAttribute(attr);
    }

    // SCROLL TO TOP OF PAGE
    function scroll_to_top(value) {
        window.scrollTo(0, 0);
    }

    // SET ELEMENT ATTRIBUTE
    function set_element_attribute(elem, attr, value) {
        document.querySelector(elem).setAttribute(attr, value);
    }

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

    // TOGGLE CSS CLASS
    function toggle_css(elem, css) {
        const elems = document.querySelectorAll(elem);
        elems.forEach(e => e.classList.toggle(css))
    }

    ////////////////////////////////////////
    // Register Functions
    Shiny.addCustomMessageHandler("add_css", function (value) {
        add_css(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("clear_input", function (value) {
        clear_input(value)
    })

    Shiny.addCustomMessageHandler("console_log", function (value) {
        console_log(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("hide_elem", function (value) {
        hide_elem(value[0], value[1]);
    });
    Shiny.addCustomMessageHandler("inner_html", function (value) {
        inner_html(value[0], value[1], value[2])
    });

    Shiny.addCustomMessageHandler("refresh_page", function (value) {
        refresh_page(value);
    });

    Shiny.addCustomMessageHandler("remove_css", function (value) {
        remove_css(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("remove_elem", function (value) {
        remove_elem(value)
    })

    Shiny.addCustomMessageHandler("remove_element_attribute", function (value) {
        remove_element_attribute(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("set_element_attribute", function (value) {
        set_element_attribute(value[0], value[1], value[2]);
    });

    Shiny.addCustomMessageHandler("scroll_to_top", function (value) {
        scroll_to_top(value);
    })

    Shiny.addCustomMessageHandler("show_elem", function (value) {
        show_elem(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("toggle_css", function (value) {
        toggle_css(value[0], value[1]);
    });

})();

////////////////////////////////////////////////////////////////////////////////

// ~ 2 ~
// Navigation, Toggles, and Buttons

// ~ a ~
// Function for handling clicks of all navigation links
(function () {
    function toTitleCase(string) {
        return string.charAt(0).toUpperCase() + string.substr(1).toLowerCase();
    }
    const links = document.querySelectorAll(".nav .menu-link");
    links.forEach(function (link) {
        link.addEventListener("click", function (event) {
            event.preventDefault();
            Shiny.setInputValue(event.target.id, event.target.id, { priority: "event" });
            document.title = `shinyTravel | ${toTitleCase(event.target.innerText)}`;
        })
    })
})();


// ~ b ~ 
// Function for opening and closing accordions to get this function to work
// you must call it on the desired page.
const accordions = (function () {
    function addToggles() {
        const buttons = document.querySelectorAll(".accordion-button");
        buttons.forEach(function (btn) {
            btn.addEventListener("click", function (e) {
                let id = btn.getAttribute("data-name", "value");
                let svg = document.querySelector(`svg[data-name="${id}"]`);
                let sec = document.querySelector(`section[data-name="${id}"]`);
                sec.classList.toggle("visually-hidden");
                svg.classList.toggle("rotated");
                if (btn.getAttribute("aria-expanded", "value") === "false") {
                    btn.setAttribute("aria-expanded", true);
                    sec.removeAttribute("hidden");
                } else {
                    btn.setAttribute("aria-expanded", "false");
                    sec.setAttribute("hidden", "");
                }
            });
        });
    }
    return {
        addToggles: addToggles
    }
})();


// ~ c ~ 
// Function to reset all radio input groups and checkbox input groups
(function () {
    function resetInputGroups() {
        const elems = document.querySelectorAll("input[type='radio'], input[type='checkbox']");
        elems.forEach(function (el) {
            el.checked = false;
            if (el.getAttribute("data-default", "value") === "true") {
                el.checked = true;
            }
        });
    }
    Shiny.addCustomMessageHandler("reset_input_groups", function (value) {
        resetInputGroups()
    })
})();

////////////////////////////////////////////////////////////////////////////////

// ~ 3 ~
// Function for handling menu opening and closing
(function () {

    // pull all elements
    const menuToggle = document.getElementById("toggle");
    const menu = document.getElementById("navlinks");
    const body = document.querySelector("body");
    const width = body.getBoundingClientRect().width;

    // init menu state
    document.addEventListener("DOMContentLoaded", function () {
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
    window.addEventListener("resize", function () {
        let w = body.getBoundingClientRect().width;
        if (w >= 912) {
            menu.classList.remove("expanded");
            menu.removeAttribute("hidden");
            menuToggle.classList.remove("open");
            menuToggle.setAttribute("aria-expanded", "false");
        }
    });
})();

////////////////////////////////////////////////////////////////////////////////

// ~ 4 ~
// D3 Visualisations


// Render Top 3 Locations Map
(function () {
    // ~ 1 ~
    // Draw Maps: Base function that renders a map and point
    // this function takes a few arguments:
    // id: the id of the html element to draw (ie., "#my-figure")
    // coords: a pair of coordinates to center the map (lon, lat)
    // name: a text string containing the name of the location
    // data: a geojson features object
    function drawMap(id, coords, name, data) {

        // set map defaults
        const width = 250;
        const height = 250;

        // define svg output element
        const svg = d3.select(id)
            .append("svg")
            .attr("class", "d3-viz d3-map top-three-cities-maps")
            .attr("width", width)
            .attr("height", height);

        // define projection
        let projection = d3.geoMercator()
            .scale(1)
            .translate([0, 0]);

        // define path
        let path = d3.geoPath().projection(projection);

        // create bounds in order to compute scale and translate
        let b = path.bounds(data[0]);
        let s = 0.8 / Math.max((b[1][0] - b[0][0]) / width, (b[1][1] - b[0][1]) / height);
        let t = [(width - s * (b[1][0] + b[0][0])) / 2, (height - s * (b[1][1] + b[0][1])) / 2];
        projection = projection.scale(s).translate(t);

        // add map layer
        const map = svg.append("g")
            .attr("data-city", name);

        // draw boundaries
        map.selectAll("path")
            .data(data)
            .enter()
            .append("path")
            .attr("fill", "#bdbdbd")
            .attr("stroke", "#c4c4c4")
            .attr("d", path);

        // add marker
        map.selectAll("circle")
            .data([coords])
            .enter()
            .append("circle")
            .attr("cx", d => projection(d)[0])
            .attr("cy", d => projection(d)[1])
            .attr("r", "9px")
            .attr("fill", "rgb(174, 117, 159)");

        // add text box for location name
        map.selectAll("rect")
            .data(data)
            .enter()
            .append("rect")
            .attr("x", 0)
            .attr("y", 220)
            .attr("width", width)
            .attr("height", 30)
            .attr("fill", "hsla(215, 45%, 53%, 0.35)");

        // add location name
        map.selectAll("text")
            .data([name])
            .enter()
            .append("text")
            .attr("x", width / 2)
            .attr("y", 240)
            .attr("text-anchor", "middle")
            .text(d => d);
    }

    // ~ 2 ~
    // Map Function
    // define a function that receives three locations from the 
    // shiny server, loads geojson file and parses map boundaries
    // of the three locations, and renders a map with the city
    // and name. The output id is predefined in the file finder.R
    // should the id change, make sure it is updated here.
    // This function has one input argument which contains all three
    // cities,
    function render_top_city_maps(city_a, city_b, city_c) {

        // Remove Existing Maps
        d3.selectAll("#recommended-cities .top-three-cities-maps, #recommended-cities .error").remove();

        // define output id
        const out_elem = "#recommended-cities";
        // run fetch
        d3.json("../data/eu.topojson", response => {
            if (repsonse.ok) {
                return response;
            } else {
                throw response;
            }
        }).then(result => {

            // Pull Data
            const countries = [city_a.country, city_b.country, city_c.country];
            let geojson = topojson.feature(result, result.objects.europe);
            geojson.features = geojson.features.filter(d => {
                // console.log(d.properties.name);
                return countries.indexOf(d.properties.name) > -1;
            });

            // Build Map For City A
            if (city_a !== false) {
                let coordsA = [city_a.lng, city_a.lat];
                let countryA = geojson.features.filter(d => d.properties.name === countries[0]);
                drawMap(out_elem, coordsA, city_a.city, countryA)
            }

            // Build Map For City B
            if (city_b !== false) {
                let coordsB = [city_b.lng, city_b.lat];
                let countryB = geojson.features.filter(d => d.properties.name === countries[1]);
                drawMap(out_elem, coordsB, city_b.city, countryB)
            }

            // Build Map For City C
            if (city_c !== false) {
                const coordsC = [city_c.lng, city_c.lat];
                let countryC = geojson.features.filter(d => d.properties.name === countries[2]);
                drawMap(out_elem, coordsC, city_c.city, countryC)
            }

            // Output Message if no data submitted
            // this check will likely not be needed, but in the event
            // the r code fails (for some reason) an error message will
            // be displayed
            if (!city_a && !city_b && !city_c) {
                d3.select(out_elem)
                    .append("p")
                    .attr("class", "error")
                    .text("Sorry, no results were returned. Either select more countries or reset the number of cities to remove.")
            }

        }).catch(error => {
            d3.select(out_elem)
                .append("p")
                .attr("class", "error")
                .text(`ERROR: ${error}`);
            console.log(error);
        })
    }

    // Register with Shiny and evaluate the presence of all three cities
    Shiny.addCustomMessageHandler("render_top_city_maps", function (value) {
        let city_a, city_b, city_c;
        if (value.length > 0) {
            if (value.length === 1) {
                city_a = value[0];
                city_b = false;
                city_c = false;
            }
            if (value.length === 2) {
                city_a = value[0];
                city_b = value[1];
                city_c = false;
            }
            if (value.length === 3) {
                city_a = value[0];
                city_b = value[1];
                city_c = value[2];
            }
        } else {
            city_a = false;
            city_b = false;
            city_c = false;
        }
        render_top_city_maps(city_a, city_b, city_c);
    })

})();

////////////////////////////////////////////////////////////////////////////////

// ~ 5 ~
// D3 Visualizations Tables

// function and handler to generate data tables
(function () {

    // function for evaluating classnames for td elements
    function set_classname(value, col) {
        let css;
        const datatype = typeof value;
        if (datatype === "number") {
            if (value > 0) {
                css = "datatype-number value-positive";
            } else if (value < 0) {
                css = "datatype-number value-negative";
            } else if (value === 0) {
                css = "datatype-number value-zero"
            }
        } else {
            css = `datatype-${typeof value}`;
        }
        css = css + " column-" + (col + 1);
        return (css)
    }

    // build datatable
    function datatable(id, data, columns, caption, css) {

        // define table
        d3.select(`${id} table`).remove();
        const table = d3.select(id)
            .append("table")
            .attr("class", "datatable");

        // update css if present
        if (css) {
            table.attr("class", `datatable ${css}`)
        }

        // render caption
        if (caption) {
            table.append("caption").text(caption)
        }

        // <thead>
        const thead = table.append("thead")
            .attr("class", "datatable-head")
            .append("tr")
            .attr("role", "row")
            .selectAll("th")
            .data(columns)
            .enter()
            .append("th")
            .attr("scope", "col")
            .attr("class", (d, i) => `column-${i + 1}`)
            .text(c => c);

        // // <tbody>
        const tbody = table.append("tbody")
            .attr("class", "datatable-body");

        // // create rows
        const rows = tbody.selectAll("tr")
            .data(data)
            .enter()
            .append("tr")
            .attr("role", "row");

        // create cells
        const cells = rows.selectAll("td")
            .data(function (row) {
                return columns.map(function (column) {
                    return {
                        column: column,
                        value: row[column]
                    };
                });
            })
            .enter()
            .append("td")
            .attr("role", "cell")
            .attr("class", (d, i) => { return set_classname(d.value, i); });

        // create responsive cells
        cells.text(d => d.value)
        cells.append("span")
            .attr("class", "hidden-colname")
            .attr("aria-hidden", "true")
            .text(d => d.column)
            .lower()
    }

    // shiny handler
    Shiny.addCustomMessageHandler("render_datatable", function (value) {
        setTimeout(function () {
            datatable(
                id = value[0],
                data = value[1],
                columns = value[2],
                caption = value[3],
                css = value[4]
            )
        }, 500)
    })

})();

////////////////////////////////////////////////////////////////////////////////

// function for rendering columncharts

(function () {
    // function for determining yMax value
    function ymax(value, data, y) {
        if (typeof value === "undefined") {
            let val = Math.max(...data.map(function (d) { return [d[y]]; }));
            if (val <= 0) {
                val = 0;
            }
            return val;
        } else {
            return value;
        }
    }

    // function for determining the ymin value
    function ymin(value, data, y) {
        if (typeof value === "undefined") {
            let val = Math.min(...data.map(function (d) { return [d[y]]; }));
            if (val >= 0) {
                val = 0
            }
            return val
        } else {
            return value;
        }
    }
    function columnChart({ id, data, x, y, yMin, yMax }) {
        // set params
        let width = 550, height = 300, scale = 1.05;
        const margin = ({ top: 35, right: 0, bottom: 35, left: 35 });
        const range = {
            ymin: ymin(yMin, data, y),
            ymax: ymax(yMax, data, y)
        }

        // select and define svg element
        let svg = d3.select(id)
            .append("svg")
            .attr("class", "d3-viz column-chart")
            .attr("width", "100%")
            .attr("height", "100%")
            .attr("viewBox", ` 0 0 ${width * scale} ${height}`)
            .attr("preserveAspectRatio", "xMinYMin");

        // append inner svg aread
        let g = svg.append("g")
            .attr("transform", `translate(${margin.left}, ${margin.top})`);

        // define group for all coumns
        let columnArea = g.append("g")
            .attr("class", "chart-data")
            .selectAll("chart-data");

        // define axes
        let xScale = d3.scaleBand()
            .domain(data.map(d => d[x]))
            .range([0, width - margin.left - margin.right]);
        let yScale = d3.scaleLinear()
            .domain([range.ymin, range.ymax])
            .nice()
            .range([height - margin.top - margin.bottom, 0]);

        // render x
        g.append("g")
            .attr("class", "axis x-axis")
            .attr("transform", `translate(0, ${yScale(0)})`)
            .call(d3.axisBottom(xScale));

        // render y
        g.append("g")
            .attr("class", "axis y-axis")
            .call(d3.axisLeft(yScale));

        // build columns
        let columns = columnArea
            .data(data)
            .enter()
            .append("g")
            .attr("transform", d => `translate(${xScale(d[x])}, 0)`);

        // BUILD <rect>
        let rect = columns
            .append("rect")
            .attr("x", xScale.bandwidth() * 0.2)
            .attr("y", yScale(0))
            .attr("width", xScale.bandwidth() * 0.5 + 10)
            .style("cursor", "pointer");

        // Animate
        rect.attr("height", 0)
            .transition()
            .delay(250)
            .duration(1250)
            .attr("y", (d) => yScale(Math.max(0, d[y])))
            .attr("height", d => Math.abs(yScale(d[y]) - yScale(0)));


        // tooltips
        let tooltip = d3.select("body")
            .append("div")
            .style("position", "absolute")
            .attr("id", `${id}-tooltip`)
            .attr("class", "d3-tooltip")
            .style("opacity", 0)
            .style("z-index", 200)
            .style("background-color", "white")
            .style("box-shadow", "0 0 4px 2px hsl(0, 0%, 0%, 0.2)")
            .style("border-radius", "3px")
            .style("padding", "12px 18px")

        // define events
        function mouseover(d) {
            // d3.select(this).attr("fill", config.colors.hover);
            tooltip.style("opacity", 1);
        }

        function mousemove(d) {
            tooltip.html("<strong>" + d[x] + "</strong>: " + "<output>" + d[y] + "</output>")
                .style("left", (d3.event.pageX + 10) + "px")
                .style("top", (d3.event.pageY - 55) + "px");
        }

        function mouseleave(d) {
            // d3.select(this).attr("fill", config.colors.fill);
            tooltip.style("opacity", 0);
        }

        // attach mouse events
        rect.on("mouseover", mouseover)
            .on("mousemove", mousemove)
            .on("mouseleave", mouseleave);
    }

    // function to render all three column charts
    function render_city_column_charts(city_a, city_b, city_c) {
        const id = "#summary-of-cities";
        if (city_a !== false) {
            columnChart({id: id, data: city_a, x: "place", y: "rate", yMax: 100})
        }
        if (city_b !== false) {
            columnChart({id: id, data: city_a, x: "place", y: "rate", yMax: 100})
        }
        if (city_c !== false) {
            columnChart({id: id, data: city_a, x: "place", y: "rate", yMax: 100})
        }
    }

    // handler to render all three charts if they exist
    Shiny.addCustomMessageHandler("render_city_column_charts", function(value) {
        const keys = Array.from(new Set([...value.map(d => d.id)]));
        let city_a, city_b, city_c;
        if (keys.length > 0) {
            if (keys.length === 1) {
                city_a = value.filter(d => d.id === keys[0]);
                city_b = false;
                city_c = false;
            }
            if (keys.length === 2) {
                city_a = value.filter(d => d.id === keys[0]);
                city_b = value.filter(d => d.id === keys[1]);
                city_c = false;
            }
            if (keys.length === 3) {
                city_a = value.filter(d => d.id === keys[0]);
                city_b = value.filter(d => d.id === keys[1]);
                city_c = value.filter(d => d.id === keys[3]);
            }
        } else {
            city_a = false;
            city_b = false;
            city_c = false;
        }
        render_city_column_charts(city_a, city_b, city_c);
    })

})();