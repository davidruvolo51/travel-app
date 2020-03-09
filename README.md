
![shiny travel app](travel-app.png)

# shinyTravel

This repo contains the code and data used in my Shiny 2020 contest submission: [shinyTravel](#). My submission is an app that provides travel recommendations for European cities based on your preference for specialty coffee, breweries, and museums. 

The application demonstrates how to design and develop a custom shiny application using my favorite frontend development tools ([sass](https://sass-lang.com), [babel](https://babeljs.io), [parcel.js](https://parceljs.org), and more) and visualization libraries ([d3](https://d3js.org) and [mapbox](https://www.mapbox.com)). Data was sourced using web scrapers, [overpass api](http://overpass-api.de) queries, and [nominatim](https://nominatim.org) queries.

You can find out more about the application in the following places

- [travel-app](https://github.com/davidruvolo51/travel-app): repo for all code and data used to create the app (current repo)
- [travel-app-data](https://github.com/davidruvolo51/travel-app-data): repo for all code for sourcing data
- [About this submission](#): I wrote a bit more about the app on my site.

## Run

A live version of the application can be found here: [coming soon](#).

There are a few options to run the application locally. The easiest is likely through the R console itself. Alternatively, you can clone the repo and run in RStudio by opening the R project file.

```r
shiny::runGithub(repo = "travel-app", username = "davidruvolo51")
```

## Develop

The purpose of this guide is to provide an overview on the tools required to develop the app. The simplest way to get started working on the shiny app is to open the `travel-app.Rproj` file in RStudio. You will also need to install a few command line tools to enable all of the plugins. Alternatively, I would recommend using vscode for this project for better support for JavaScript and CSS. [radian](https://github.com/randy3k/radian) is an excellent alternative for running R code in vscode.  

### Installation

To develop the application, you will need a few tools. All commands should be run in the terminal.

1. Install [node and npm](https://nodejs.org/): download and run the latest installer (this will install both node and npm). Run the following commands to confirm the installation.

```bash
node -v
npm -v
```

2. Install `yarn`. I'm using a pre 2.0 version in favor of global use. See the full instructions here [https://classic.yarnpkg.com/en/docs/install](https://classic.yarnpkg.com/en/docs/install). (You may also need to install [brew](https://brew.sh)).

```bash
brew install yarn
```

3. Use `npm` to install [parcel](https://parceljs.org) bundler globally.

```bash
npm install -g parcel-bundler
```

To validate the installation of parcel, run the following command.

```bash
parcel --version
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

### Scripts

There are a number of build scripts listed in the `package.json` file. These scripts are aliases for running lengthy commands in the terminal. I created a few scripts to this project. These are listed in the following table.

| Script | Description |
| :----- | :----------- 
| `shiny` | starts the shiny server @ `localhost:8000`
| `sass`  | watches and rebuilds changes to scss files in `src/styles`. The css output is written to `www/css/styles.min.css`
| `sass_build` | A script for building scss for production with plugins. The output files are written to `www/css/`
| `js_build` | A script for building all javascript code for production with plugins. The input file is `www/js/index.js` and the output is `www/js/index.min.js`. 
| `sass_clean` | a script for removing production files and clearing the sass cache
| `js_clean` | a script from removing production files

To run a script, use `yarn [script_name]`. For example, to start the shiny server, you would run the following command and then navigate to `http://localhost:8000` in your browser.

```bash
yarn shiny
```

Before running the build scripts, run the corresponding cleaner script to clear existing files and remove cache. 

Depending on the type of development you are doing, make sure the correct tags are uncommented/commented in the `ui.R` file.

```R
# tags$script(src = "js/index.js"),
tags$script(src = "js/index.min.js")
```

### Tips


**1. `.gitignore`**

If you are creating your own custom shiny app using npm packages, I would recommend using the `.gitignore` file. Pushing the entire `node_modules` is not needed as it's easy to install these tools locally and the size of this folder can be very large (sometimes approaching 1GB).

```bash
touch .gitignore
printf "node_modules/\n.cache/\n" >> .gitignore
```

**2. Terminal Management**

I would recommend using [tmux](https://github.com/tmux/tmux) for running multiple scripts in a single terminal view. This will allow you to run the `shiny` script and `sass` script simultaneously and prevents crowding of the terminal window when there are errors.