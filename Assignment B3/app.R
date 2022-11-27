#This Shiny web application builds upon Dean Attali's BCLiquor Shiny app.
# The following app.R file can be opened in RStudio and 'RunApp' will launch the app.

#Several packages must be loaded for this app to work.
library(shiny)
library(tidyverse)
library(DT)
library(shinyWidgets)
library(BH)

bcl <- read_csv("bcl-data.csv")

ui <- fluidPage(
  titlePanel("BC Liquor Store Data"),
  h5("Welcome to Liam's version of this shiny app, initially created by Dean Attali!"),
  br(),
  sidebarLayout(
  #Feature 1A: Adding the BC Liquor logo. This adds to the user interface, making the app more visually appealing.
    sidebarPanel(
      img(src = "bc-liquor-store-logo.png"),
      sliderInput("priceInput", "Price", 0, 100,
              value = c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE"),
#Feature 2: Adding selector options for the
# country of the product and subtype.
# Be careful! Not all liquor types have all subtypes.
#These multi-selector dropdown menus allow onne to view products from many/all countries and across many subtypes.

      uiOutput("countryOutput"),
      uiOutput("subtypeOutput")),

      mainPanel(
#Feature 1B: Adding a fun, relevant gif! This adds to the user interface, making the app more visually appealing.
        img(src = "giphy.gif"),
        plotOutput("alcohol_hist"),
#Feature 3: Using a different package (DT) to produce an interactive table.
#This table shows the number of entries for the criteria and is searchable, allowing the user to further tailor the results to their liking.
      DT::dataTableOutput("mytable"),
    )
  ),
  a(href="https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv",
    "Link to the original data set")
)

server <- function(input, output) {

  filtered_data <-
    reactive({
      bcl %>% filter(Price > input$priceInput[1] &
                   Price < input$priceInput[2] &
                   Type == input$typeInput,
                   Country == input$countryInput,
                   Subtype == input$subtypeInput)
    })

  output$countryOutput <- renderUI({
    pickerInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                multiple = "TRUE",
                options = list('actions-box' = TRUE),
                selected = "CANADA"
                )
  })

  output$subtypeOutput <- renderUI({
    pickerInput("subtypeInput", "SUBTYPE",
                sort(unique(bcl$Subtype)),
                multiple = "TRUE",
                options = list('actions-box' = TRUE),
                selected = "TABLE WINE RED" )
  })

  output$alcohol_hist <-
    renderPlot({
      filtered_data() %>%
      ggplot(aes(Alcohol_Content)) + geom_histogram()

    })

  output$mytable = DT::renderDataTable({
   filtered_data()


  })

}

shinyApp(ui = ui, server = server)
