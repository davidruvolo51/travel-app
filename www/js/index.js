////////////////////////////////////////////////////////////////////////////////
// FILE: index.js
// AUTHOR: David Ruvolo
// CREATED: 2020-02-14
// MODIFIED: 2020-03-05
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

    // LOG SOMETHING TO THE CONSOLE
    function console_log(value, asDir) {
        if (asDir) {
            console.dir(value);
        } else {
            console.log(value);
        }
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

    ////////////////////////////////////////
    // Register Functions
    Shiny.addCustomMessageHandler("add_css", function (value) {
        add_css(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("console_log", function (value) {
        console_log(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("inner_html", function (value) {
        inner_html(value[0], value[1], value[2])
    });

    Shiny.addCustomMessageHandler("remove_css", function (value) {
        remove_css(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("remove_elem", function (value) {
        remove_elem(value)
    });

    Shiny.addCustomMessageHandler("remove_element_attribute", function (value) {
        remove_element_attribute(value[0], value[1]);
    });

    Shiny.addCustomMessageHandler("set_element_attribute", function (value) {
        set_element_attribute(value[0], value[1], value[2]);
    });

    Shiny.addCustomMessageHandler("scroll_to_top", function (value) {
        scroll_to_top(value);
    });
})();

////////////////////////////////////////////////////////////////////////////////

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
            btn.addEventListener("click", function (event) {
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
// (function () {
//     function resetInputGroups() {
//         let elems = document.querySelectorAll("input[type='radio'], input[type='checkbox']");
//         elems.forEach(function (el) {
//             el.checked = false;
//             if (el.getAttribute("data-default", "value") === "true") {
//                 el.checked = true;
//             }
//         });
//         let groups = document.querySelectorAll("fieldset[role='radioinputgroup'], fieldset[role='checkboxgroup']");
//         groups.forEach(function (el) {
//             console.log(el)
//             el.value = "";
//         })
//     }

//     Shiny.addCustomMessageHandler("reset_form", function (value) {
//         resetInputGroups()
//         // document.getElementById(value).reset();
//     })
// })();

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
            const countries = [city_a.country, city_b.country, city_c.country].map(d => {
                return d === "Czech Republic" ? "Czech Rep." : d
            });
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

// map box code
const map = (function () {

    // public token
    mapboxgl.accessToken = "pk.eyJ1IjoiZGNydXZvbG8iLCJhIjoiY2psaW9mZXpmMDNkZDNxcG54cDd2OTJ4YyJ9.qjJnQuhtjHfZ4zBzRyB74g"

    function render_mapbox(id) {
        // build map
        let map = new mapboxgl.Map({
            container: id,
            style: "mapbox://styles/mapbox/dark-v10",
            center: [11.3351122, 44.4941305], // set to Bologna
            pitch: 10,
            zoom: 0,
            maxBounds: [
                [-33.014707, 29.886634], // southwest coords
                [49.469993, 75.898085]   // northeast coords
            ],
            antialias: true
        })

        // when loaded add layers
        map.on('load', function () {

            // Insert the layer beneath any symbol layer.
            var layers = map.getStyle().layers;

            var labelLayerId;
            for (var i = 0; i < layers.length; i++) {
                if (layers[i].type === 'symbol' && layers[i].layout['text-field']) {
                    labelLayerId = layers[i].id;
                    break;
                }
            }

            // add buildings
            map.addLayer({
                'id': '3d-buildings',
                'source': 'composite',
                'source-layer': 'building',
                'filter': ['==', 'extrude', 'true'],
                'type': 'fill-extrusion',
                'minzoom': 15,
                'paint': {
                    'fill-extrusion-color': '#aaa',

                    // use an 'interpolate' expression to add a smooth transition effect to the
                    // buildings as the user zooms in
                    'fill-extrusion-height': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        15,
                        0,
                        15.05,
                        ['get', 'height']
                    ],
                    'fill-extrusion-base': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        15,
                        0,
                        15.05,
                        ['get', 'min_height']
                    ],
                    'fill-extrusion-opacity': 0.6
                }
            },
                labelLayerId
            );

            // add coords
            map.addSource("destinations", {
                type: "geojson",
                data: "https://raw.githubusercontent.com/davidruvolo51/travel-app/master/www/data/travel.geojson"
            });

            // add circles
            map.addLayer({
                'id': 'locations',
                'type': 'circle',
                'source': 'destinations',
                'paint': {
                    'circle-radius': {
                        'base': 1.75,
                        'stops': [[12, 2], [22, 180]]
                    },
                    'circle-color': [
                        'match',
                        ['get', 'type'],
                        'brewery', '#66c2a5',
                        'cafe', "#fc8d62",
                        'museum', "#8da0cb",
                        // other
                        "#ffffff"
                    ]
                }
            });

            // add icons
            map.addLayer({
                'id': 'destinations',
                'type': 'symbol',
                'source': 'destinations',
                'layout': {
                    'icon-image': '{icon}-15',
                    'icon-allow-overlap': true,
                    'icon-ignore-placement' : true,
                    'icon-size': {
                        'base': 0.7,
                        'type': 'exponential',
                        'stops': [
                            [10, 0],
                            [12, 0.8],
                            [15, 0.8],
                            [18, 1]
                        ]
                    },
                }
            });

            // mouse enter
            map.on("mouseenter", "destinations", function (e) {
                map.getCanvas().style.cursor = "pointer";
            })

            // onclick
            map.on('click', 'destinations', function (e) {
                // Change the cursor style as a UI indicator.
                map.getCanvas().style.cursor = 'pointer';

                var coordinates = e.features[0].geometry.coordinates.slice();
                var description = `
                <span class="place-type">${e.features[0].properties.type}</span>
                <strong class="place-name">${e.features[0].properties.name}</strong>
                <span class="place-city">${e.features[0].properties.city}</span>
                <span class="place-country">${e.features[0].properties.country}</span>
                <span class="place-id">${e.features[0].properties.id}</span>
            `;

                // Ensure that if the map is zoomed out such that multiple
                // copies of the feature are visible, the popup appears
                // over the copy being pointed to.
                while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
                    coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
                }

                // Populate the popup and set its coordinates
                // based on the feature found.
                new mapboxgl.Popup({ className: "place-popup" })
                    .setMaxWidth("300px")
                    .setLngLat(coordinates)
                    .setHTML(description)
                    .addTo(map);
            });

            // on leave
            map.on('mouseleave', 'destinations', function () {
                map.getCanvas().style.cursor = '';
            });
        });
    }

    return {
        render_mapbox: render_mapbox
    }

})();
