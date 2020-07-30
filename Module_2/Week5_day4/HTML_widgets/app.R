library(leaflet)
library(CodeClanData)
library(shiny)
library(dplyr)
ui <- fluidPage (
    selectInput("region", "Which Region?", unique(whisky$Region)), 
    leafletOutput("map")
)
server <- function(input, output) {
    output$map <- renderLeaflet({
        whisky %>%
            filter(Region == input$region) %>%
            leaflet() %>% 
            addTiles() %>%
            addCircleMarkers(lat = ~Longitude, lng = ~Latitude, popup = ~Distillery)
    })
}
shinyApp(ui, server)