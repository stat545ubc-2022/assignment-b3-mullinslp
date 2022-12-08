#This Shiny web application builds upon Dean Attali's BCLiquor Shiny app and
# Liam's first release of the app for Assignment B3.
# The following app.R file can be opened in RStudio and 'RunApp' will launch the app.

#Several packages must be loaded for this app to work.
library(shiny)
library(tidyverse)
library(DT)
library(shinyWidgets)
library(BH)
library(shinythemes)

bcl <- read_csv("bcl-data.csv")

ui <- fluidPage(theme = shinytheme("cosmo"),
  titlePanel("BC Liquor Store Data"),
  h5("Welcome to Liam's version of this shiny app, initially created by Dean Attali!"),
  br(),
  sidebarLayout(
#Feature #1A: Adding the BC Liquor logo. This adds to the user interface, making the app more visually appealing.
    sidebarPanel(
      img(src = "bc-liquor-store-logo.png"),
      sliderInput("priceInput", "Price", 0, 100,
              value = c(25, 40), pre = "$"),
      uiOutput("typeOutput"),
#Feature #2: Adding selector options for the
#country of the product. Note: subtype was included in the previous release but has been removed.
#This is because it is more intuitive to search subtypes within the interactive table itself.
#The multi-selector dropdown menu allow one to view products from many/all countries.
      uiOutput("countryOutput")),

      mainPanel(
#Feature #3 *New to this version*: Including the data table and plot in separate tabs improves the user interface.
#Together, these two features dislpay too much information for a user to process.
#Separately, the user can select which they would like to view usinng the tabs.

#Feature #4: Using a different package (DT) to produce an interactive table.
#This table shows the number of entries for the criteria and is searchable, allowing the user to further tailor the results to their liking.
        tabsetPanel(
           tabPanel("List my options",
                   h3(textOutput("summaryText")),
                   DT::dataTableOutput("mytable"),
                   downloadButton("download", "Download My Options")),
#Feature #5 *New to this version*: The inclusion of the download button allows the user to download a copy of the table results.
#This is helpful if a user wants to purchase any products.
# The user can  Simply download the results and keep handy on a mobile device as they shop at BCLiquor.

#Feature #6 *New to this version*: The inclusion of the text output here, "summaryText", provides a handy header displaying the number of results.
#This is a clearer way to show the user how many options they have with their selected criteria.

#Feature #1B: Adding a fun, relevant gif! This adds to the user interface, making the app more visually appealing.
          tabPanel("Plot my options",
                   img(src = "giphy.gif",
                       style="display: block; margin-left: auto; margin-right: auto;"),
                   plotOutput("alcohol_hist"))),
  )),
  a(href="https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv",
    "Link to the original data set")
)

server <- function(input, output) {

  filtered_data <-
    reactive({
      bcl %>% filter(Price > input$priceInput[1] &
                   Price < input$priceInput[2] &
                   Type == input$typeInput,
                   Country == input$countryInput)

    })

  output$typeOutput <- renderUI({
      selectInput("typeInput", "TYPE",
                  sort(unique(bcl$Type)),
                  multiple = TRUE,
                  selected = "WINE" )

  })

  output$summaryText <- renderText({
    numOptions <- nrow(filtered_data())
    if (is.null(numOptions)) {
      numOptions <- 0
    }
    paste0("We found ", numOptions, " options for you")

  })
    output$countryOutput <- renderUI({
      pickerInput("countryInput", "COUNTRY",
                  sort(unique(bcl$Country)),
                  multiple = TRUE,
                  options = list('actions-box' = TRUE),
                  selected = c("CANADA"))
  })
    output$subtypeOutput <- renderUI({
      selectInput("subtypeInput", "SUBTYPE",
                  sort(unique(bcl$Subtype)),
                  multiple = TRUE,
                  options = c(bc))
  })
    output$alcohol_hist <-
     renderPlot({
      filtered_data() %>%
      ggplot(aes(Alcohol_Content, fill = Type)) + geom_histogram()
  })
  output$mytable = DT::renderDataTable({
   filtered_data()
  })
  output$download <- downloadHandler(
    filename = function() {
      "bcl-results.csv"
    },
    content = function(con) {
      write.csv(filtered_data_(), con)
    }
  )
}

shinyApp(ui = ui, server = server)
