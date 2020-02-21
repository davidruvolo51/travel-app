////////////////////////////////////////////////////////////////////////////////
// FILE: bubbles.js
// AUTHOR: David Ruvolo
// CREATED: 2020-02-21
// MODIFIED: 2020-02-21
// PURPOSE: 
// DEPENDENCIES: 
// STATUS: 
// COMMENTS: 
////////////////////////////////////////////////////////////////////////////////
// BEGIN

// imports
import {select, selectAll, data, append} from "d3";

// defaults
const bubbleDefs = {
    width: 600,
    height: 375,
    fill: "#bdbdbd",
    chartScaling: 1.15
}

// function
export function bubbles(id, data) {
    
    // select primary elements
    const parent = select(id);
    const svg = parent.append("svg");

    // update svg
    svg.attr("width", "100%")
        .attr("height", "100%")
        .attr("viewBox", `0 0 ${bubbleDefs.width * bubbleDefs.chartScaling} ${bubbleDefs.height}`)
        .attr("preserveAspectRation", "xMinYmin");

    // render <circle>
    const circles = svg.selectAll("circle")
        .data(data)
        .enter()
        .append("circle")
        .attr("class", "bubble")
        .attr("id", d => `bubble-${d.toLowerCase()}`)
        .text(d => d);
} 