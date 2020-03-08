
<div style="width: 100%; text-align: center;">

![shiny travel app](./www/images/shiny-travel-illustration.svg)

</div>

# Travel App

This repo contains the code and data used in my Shiny 2020 contest submission: [shinyTravel](#). My submission is an app that provides recommendations for European cities to travel to based on your preference for speciality coffee, breweries, and museums. The app also provides an interactive map to explore all locations in the dataset. 

The application demonstrates how to design and develop a custom shiny application using my favorite frontend development tools ([sass](https://sass-lang.com), [babel](https://babeljs.io), [parcel.js](https://parceljs.org), and more) and visualisations libraries ([d3](https://d3js.org) and [mapbox](https://www.mapbox.com)). Data was sourced using web scrapers, [overpass api](http://overpass-api.de) queries, and [nominatim](https://nominatim.org) queries. Google Places API was also used. More information about the data sourcing process can be found in the [wiki](https://github.com/davidruvolo51/travel-app/wiki) and all code can be found in the [travel-app-data](https://github.com/davidruvolo51/travel-app-data) repo.

## Run

A live version of the application can be found here: [tbd](#).

There are a few options to run the application locally. The easiest is likely through the R console itself. Alternatively, you can clone the repo and run in RStudio.

```r
shiny::runGithub(repo = "travel-app", username = "davidruvolo51")
```

If you have cloned the app, you can run the app in RStudio or using the `shiny` script (see the following section for more information).

```bash
yarn shiny
```

## Develop

To develop the application, you will need a few tools. All commands should be run in the terminal unless specified otherwise.

1. Install [node and npm](https://nodejs.org/): download and run the latest installer (this will install both node and npm). Run the following commands to confirm the installation.

```bash
node -v
npm -v
```

2. Install `yarn`. I'm using a pre 2.0 version in favor of global use. See the full instructions here [https://classic.yarnpkg.com/en/docs/install](https://classic.yarnpkg.com/en/docs/install). (Mac users may also need to install [brew](https://brew.sh)).

```bash
brew install yarn
```

3. Use `npm` to install [parcel](https://parceljs.org) bundler globally.

```bash
npm install -g parcel-bundler
```

4. Clone the [travel-app](https://github.com/davidruvolo51/travel-app) repository into a directory of your choice.

```bash
cd path/to/my/favorite/location
git clone https://github.com/davidruvolo51/travel-app
```

5. Install all dependencies listed in the `package.json` file.

```bash
yarn install
```

6. There are a number of build scripts listed in the `package.json` file. These scripts are used to start the development servers for `sass`, `shiny`, and to compile the main `javascript` file. To run a script use `yarn` + `[script name]`.

```bash
yarn shiny        # shiny: runs server @ localhost:8000
yarn sass         # sass: watches and rebuilds scss changes (for dev)
yarn sass_build   # sass: transpiles and minifies scss (for prod)
yarn js_build     # babel: transiples and minifies js (for prod)
```

There is no dev script for js. Before running the build scripts, run the corresponding cleaner script to clear existing files and remove cache, e.g., `yarn sass_clean`, `yarn js_clean`.

In the `ui.R` file, make sure the correct script is uncommented (i.e., `tags$script(src = "js/index.js")` or `tags$script(src = "js/index.min.js"`).

To start the app, use `yarn shiny`. This will run the shiny server at port `8000`. Open a browser and navigate to `http://localhost:8000` to view the app.

I would recommend using [tmux](https://github.com/tmux/tmux) for running multiple scripts in a single terminal view.