library(ggplot2)
library(shiny)
library(dplyr)
library(CodeClanData)
library(DT)


ui <- fluidPage(
    fluidRow(
        column(3,
               selectInput("dog_colour",
                           "Select dog colour",
                           choices = unique(nyc_dogs$colour))
        ),
        column(3, 
               selectInput("borough",
                           "Select Borough",
                           choices = unique(nyc_dogs$borough))
        ),
        column(3, 
               selectInput("dog_breed",
                           "Select breed",
                           choices = unique(nyc_dogs$breed))
        ),
        
        #tableOutput is shiny default, 
        dataTableOutput("table_output")   #dataTableOutput is from package DT - recommended to use
    )
)

server <- function(input, output) {
    
    output$table_output <- renderDataTable({
        
        nyc_dogs %>%
            filter(colour == input$dog_colour) %>%
            filter(borough == input$borough) %>%
            filter(breed == input$dog_breed)
        #slice(1:10)
    })
    
}

shinyApp(ui = ui, server = server)