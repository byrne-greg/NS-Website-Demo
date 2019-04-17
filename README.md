# NS-Website
[Template website for a national school.](https://byrne-greg.github.io/NS-Website/index.html)

## What is this?
It is a collection of webpages whose content is generated using [XSL transformations](https://www.w3schools.com/xml/xsl_intro.asp]) around a data layer consisting of XML files. The webpages are based around the theme and basic requirements for a national school. 

The content and structure (i.e. HTML) are defined within the stylesheet and use the data contained with the XML. These are generated at build time. The other static artefacts consist of CSS for styling, Javascript (JQuery) for the behaviour, and images. Responsive web design is used to ensure displays between mobile and desktop screens are mostly consistent.

The generated HTML is source controlled for hosting using [Github Pages](https://pages.github.com/).

### Technologies Used
* HTML
* CSS
   * Particularly [Grid](https://www.w3schools.com/css/css_grid.asp) and [Flexbox](https://www.w3schools.com/css/css3_flexbox.asp)
* Javascript
    * Particularly [JQuery](https://jquery.com/)
* XSLT 1.0
* XML
* [Apache ANT](https://ant.apache.org/)
* Git for version control (obviously!)

## Requirements
1. [Apache ANT](https://ant.apache.org/bindownload.cgi) (to generate the HTML from XSL transformation using the [XSLT task](https://ant.apache.org/manual/Tasks/style.html)).
    * *Note*: Xalan, required for XSL transformations, comes bundled with Apache ANT.

## How to generate
1. Run the `build.sh` file. This will call the build script that copies the master web artefacts (CSS, JS, images, etc.) and generates the HTML artefacts within the `./docs` folder.

## Understanding file structure
* `./bin` contains binaries and build files.
* `./data` contains data files used during transformation.
* `./docs` contains the generated pages and copy of web artefacts. Directory is used for hosting.
* `./css` contains the master copy of the stylesheet. Copied to the `docs` directory when building.
* `./js` contains the master copy of the Javascript file. Copied to the `docs` directory when building.
* `./img` contains the master copy of site images. Copied to the `docs` directory when building.
* `./icons` contains the master copy of the site icons. Copied to the `docs` directory when building.
* `./resources` contains the master copy of the downloadable site resources. Copied to the `docs` directory when building.
* `./styles` contains the XSL transformation stylesheets.

## Contributor Credit
* Special thanks to [@sinnot74](https://github.com/sinnott74) for the assistance in styling.
