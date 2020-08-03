library(CodeClanData)
library(dplyr)
library(ggplot2)
library(shiny)
ui <- fluidPage(
    fluidRow(
        column(4,
               sliderInput("bins", 
                           "Number of Bins",
                           min = 1, max = 100, value = 30)
        ),
        column(4,
               sliderInput("alpha",
                           "Alpha of Points",
                           min = 0, max = 1, value = 0.8)
        ),
        column(4,
               sliderInput("max_height",
                           "Maximum Height to Plot",
                           min = min(students_big$height),
                           max = max(students_big$height), 
                           value = max(students_big$height))
        )
    ),
    
    actionButton("update", "Update Height!"),
    
    fluidRow(
        column(6,
               plotOutput("histogram")
        ),
        column(6,
               plotOutput("scatter")
        )
    )
)
server <- function(input, output) {
    
    students_filtered <- eventReactive(input$update, {
        
        students_big %>%
            filter(height == input$max_height)
    })
    output$histogram <- renderPlot({
        ggplot(students_filtered()) +
            aes(x = height) +
            geom_histogram(bins = input$bins)
    })
    output$scatter <- renderPlot({
        ggplot(students_filtered()) +
            aes(x = height, y = arm_span) +
            geom_point(alpha = input$alpha)
    })
}
shinyApp(ui = ui, server = server)