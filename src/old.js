// function for rendering columncharts

// (function () {
//     // function for determining yMax value
//     function ymax(value, data, y) {
//         if (typeof value === "undefined") {
//             let val = Math.max(...data.map(function (d) { return [d[y]]; }));
//             if (val <= 0) {
//                 val = 0;
//             }
//             return val;
//         } else {
//             return value;
//         }
//     }
//     // function for determining the ymin value
//     function ymin(value, data, y) {
//         if (typeof value === "undefined") {
//             let val = Math.min(...data.map(function (d) { return [d[y]]; }));
//             if (val >= 0) {
//                 val = 0
//             }
//             return val
//         } else {
//             return value;
//         }
//     }
//     function columnChart({ id, data, x, y, z, yMin, yMax, title }) {
//         // set params
//         let width = 600, height = 300, scale = 1.05, hover_fill = "#507dbc", default_fill = "#a6bbda";
//         const margin = ({ top: 10, right: 0, bottom: 25, left: 55 });
//         const range = {
//             ymin: ymin(yMin, data, y),
//             ymax: ymax(yMax, data, y)
//         }
//         // define parent element
//         let node = d3.select(id).append("figure");
//         node.append("figcaption").text(title)
//         // select and define svg element
//         let svg = node.append("svg")
//             .attr("class", "d3-viz column-chart")
//             .attr("width", "100%")
//             .attr("height", "100%")
//             .attr("viewBox", ` 0 0 ${width * scale} ${height}`)
//             .attr("preserveAspectRatio", "xMinYMin");
//         // append inner svg aread
//         let g = svg.append("g")
//             .attr("transform", `translate(${margin.left}, ${margin.top})`);
//         // define group for all coumns
//         let columnArea = g.append("g")
//             .attr("class", "chart-data")
//             .selectAll("chart-data");
//         // define axes
//         let xScale = d3.scaleBand()
//             .domain(data.map(d => d[x]))
//             .range([0, width - margin.left - margin.right]);
//         let yScale = d3.scaleLinear()
//             .domain([range.ymin, range.ymax])
//             .nice()
//             .range([height - margin.top - margin.bottom, 0]);
//         // render x
//         g.append("g")
//             .attr("class", "axis x-axis")
//             .attr("transform", `translate(0, ${yScale(0)})`)
//             .call(d3.axisBottom(xScale));
//         // render y
//         g.append("g")
//             .attr("class", "axis y-axis")
//             .call(d3.axisLeft(yScale));
//         // build columns
//         let columns = columnArea
//             .data(data)
//             .enter()
//             .append("g")
//             .attr("transform", d => `translate(${xScale(d[x])}, 0)`);
//         // BUILD <rect>
//         let rect = columns
//             .append("rect")
//             .attr("x", xScale.bandwidth() * 0.2)
//             .attr("y", yScale(0))
//             .attr("width", xScale.bandwidth() * 0.5 + 10)
//             .attr("fill", "#a6bbda")
//             .style("cursor", "pointer");
//         // Animate
//         rect.attr("height", 0)
//             .transition()
//             .delay(250)
//             .duration(1250)
//             .attr("y", (d) => yScale(Math.max(0, d[y])))
//             .attr("height", d => Math.abs(yScale(d[y]) - yScale(0)));
//         // tooltips
//         let tooltip = d3.select("body")
//             .append("div")
//             .style("position", "absolute")
//             .attr("id", `${id}-tooltip`)
//             .attr("class", "d3-tooltip")
//             .style("opacity", 0)
//             .style("z-index", 200)
//             .style("background-color", "white")
//             .style("box-shadow", "0 0 4px 2px hsl(0, 0%, 0%, 0.2)")
//             .style("border-radius", "3px")
//             .style("padding", "12px 18px")
//         // define events
//         function mouseover(d) {
//             d3.select(this).attr("fill", hover_fill);
//             tooltip.style("opacity", 1);
//         }
//         function mousemove(d) {
//             tooltip.html(
//                     "<strong>" + d[x] + "</strong><br/>" +
//                     "<span>n: <output>" + d[z] + "</output></span><br/>" +
//                     "<span>%: <output>" + d[y] + "</output></span>"
//                 )
//                 .style("left", (d3.event.pageX + 10) + "px")
//                 .style("top", (d3.event.pageY - 55) + "px");
//         }
//         function mouseleave(d) {
//             d3.select(this).attr("fill", default_fill);
//             tooltip.style("opacity", 0);
//         }
//         // attach mouse events
//         rect.on("mouseover", mouseover)
//             .on("mousemove", mousemove)
//             .on("mouseleave", mouseleave);
//     }
//     // function to render all three column charts
//     function render_city_column_charts(city_a, city_b, city_c) {
//         d3.selectAll("#summary-of-cities figure").remove();
//         const id = "#summary-of-cities";
//         if (city_a !== false) {
//             columnChart({
//                 id: id,
//                 data: city_a,
//                 x: "place",
//                 y: "rate",
//                 z: "count",
//                 yMax: 100,
//                 title: `Summary of places in ${city_a[0]['city']} (% by type)`
//             })
//         }
//         if (city_b !== false) {
//             columnChart({
//                 id: id,
//                 data: city_b,
//                 x: "place",
//                 y: "rate",
//                 z: "count",
//                 yMax: 100,
//                 title: `Summary of places in ${city_b[0]['city']} (% by type)`
//             })
//         }
//         if (city_c !== false) {
//             columnChart({
//                 id: id,
//                 data: city_c,
//                 x: "place",
//                 y: "rate",
//                 z: "count",
//                 yMax: 100,
//                 title: `Summary of places in ${city_c[0]['city']} (% by type)`
//             })
//         }
//     }
//     // handler to render all three charts if they exist
//     Shiny.addCustomMessageHandler("render_city_column_charts", function(value) {
//         const keys = Array.from(new Set([...value.map(d => d.id)]));
//         let city_a, city_b, city_c;
//         if (keys.length > 0) {
//             if (keys.length === 1) {
//                 city_a = value.filter(d => d.id === keys[0]);
//                 city_b = false;
//                 city_c = false;
//             }
//             if (keys.length === 2) {
//                 city_a = value.filter(d => d.id === keys[0]);
//                 city_b = value.filter(d => d.id === keys[1]);
//                 city_c = false;
//             }
//             if (keys.length === 3) {
//                 city_a = value.filter(d => d.id === keys[0]);
//                 city_b = value.filter(d => d.id === keys[1]);
//                 city_c = value.filter(d => d.id === keys[2]);
//             }
//         } else {
//             city_a = false;
//             city_b = false;
//             city_c = false;
//         }
//         render_city_column_charts(city_a, city_b, city_c);
//     })
// })();