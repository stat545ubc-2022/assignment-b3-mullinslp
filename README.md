
# STAT545B: Assignments B3 + B4 by Liam Mullins

## Overview
This resporitory was created by Liam Mullins to hold information related to Assignments B3 and B4 for STAT 545B at the University of British Columbia. This README.md file contains an overview of the repository purpose and contents. 

Liam chose to complete *option A* for *Assignment B3*, adding features to an already exisiting *BC Liquor Shiny App by Dean Attali*. Liam's modified version of this app can be accessed through the following [link](http://mullinsl.shinyapps.io/BCLIQUOR_VersionLiam_STAT545)

Liam chose to complete *option C* for *Assignment B*, adding additional features to the Shiny App he edited for Assignment B3. Liam's edited version of this app can be accessed through the following [link](https://mullinsl.shinyapps.io/BCLIQUOR_Version2_Liam_STAT545/)

## Describing the most recent version of Liam's modified app (*Assignment B4*)
The modified app contains several useful features that make the user interface more helpful to access, including:
+ Feature #1: The addition of the BC liquor logo and a "cheers" gif. This contributes to the visuals of the app and adds a bit of fun to an otherwise plain interface.
+ Feature #2 *Edited since Assignment B3*: Adds a multi-selector dropdown menu where users can search for products by country(ies). This feature incorporates a select all/deselect all option should the user be initially unsure of which options to investigate further. The previous version of this app also included subtypes of alcohol as a multi-selector dropdown menu. This has been removed as it is more intuitive to search subtypes within the interactive table.
+ Feature #3 *New feature for Assignment B4*: This involves the inclusion of the data table and plot in separate tabs to improve the user interface. Together, these two features display too much information for a user to process.  
+ Feature #4: The output table has been made interactive. This means that individuals can search key words (related to products), examine the query hits easier, and see the total number of results.
+ Feature #5 *New feature for Assignment B4*: The inclusion of the download button allows the user to download a copy of the table results. This is helpful if a user wants to purchase any products. The user can simply download the results and keep the file handy on a mobile device as they shop at BCLiquor.
+ Feature #6 *New feature for Assignment B*: This feature adds a text element which displays the number of results to the user. This is based upon the selected price input, country, and product type. This allows the user to easily know how many products are available within their specified criteria.

## What's inside folder Assignment B3?
+ the app.R file contains the raw code which was used to add features to this Shiny app
+ bcl-data.csv contains the exported BC Liquor data used in the app
+ the rsconnect folder holds the  files to running and deploy the app
+ the www folder is where the two app images are stored

## What's inside folder Assignment B4?
+ the app.R file contains the raw code which was used to add features to this Shiny app
+ bcl-data.csv contains the exported BC Liquor data used in the app
+ the rsconnect folder holds the  files to running and deploy the app
+ the www folder is where the two app images are stored

## Acknowledgement
Dean Attali initially developed this app using public data from BC Liquor. This data can be found [here](https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv). Dean Attali's GitHub profile is linked [here](https://github.com/daattali).
