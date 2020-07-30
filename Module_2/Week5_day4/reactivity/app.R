library(shiny)
library(dplyr)
library(CodeClanData)
library(ggplot2)

ui <- fluidPage(
    fluidRow(
        column(6,
               radioButtons('gender',
                            'Male or Female Dogs?',
                            choices = c("Male", "Female"))
        ),
        column(6,
               selectInput("breed",
                           "Which Breed?",
                           choices = unique(nyc_dogs$breed))
        )
    ),
    fluidRow(
        column(6,
               plotOutput("colour_barchart")
        ),
        column(6,
               plotOutput("borough_barchart")
        )
    )
)
server <- function(input, output) {
    
    filtered_data <- reactive({
        nyc_dogs %>%
            filter(gender == input$gender)  %>%
            filter(breed == input$breed)
    })
    
    output$colour_barchart <- renderPlot({
        #nyc_dogs %>%
        #filter(gender == input$gender)  %>%
        #filter(breed == input$breed) %>%
        ggplot(filtered_data()) +
            geom_bar(aes(x = colour)) 
    })
    output$borough_barchart <- renderPlot({
        #nyc_dogs %>%
        #filter(gender == input$gender)  %>%
        #filter(breed == input$breed) %>%
        ggplot(filtered_data()) +
            geom_bar(aes(x = borough)) 
    })
}
shinyApp(ui = ui, server = server)