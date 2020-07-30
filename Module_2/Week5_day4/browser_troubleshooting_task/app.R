library(CodeClanData)
library(ggplot2)
library(dplyr)
library(shiny)
ui <- fluidPage(
    sliderInput("sample_size", "Sample Size", value = 50, min = 1, max = 912),
    plotOutput("histogram")
)

server <- function(input, output) {
    
    sampled_data <- reactive({
        
        students_big %>%
            select(handed, height) %>%
            sample_n(input$sample_size) 
    })
    output$histogram <- renderPlot({
        
        ggplot(sampled_data()) +
            aes(x = height) +
            geom_histogram()
    })
}
    shinyApp(ui = ui, server = server)

    
