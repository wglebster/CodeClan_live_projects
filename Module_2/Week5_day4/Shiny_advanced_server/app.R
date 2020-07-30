library(ggplot2)
library(shiny)
library(dplyr)
library(CodeClanData)
library(DT)


ui <- fluidPage(
    radioButtons("gender",
                 "Male or Female Dogs?",
                 choices = c("Male", "Female")),
    
    #tableOutput is shiny default, 
    dataTableOutput("table_output")   #dataTableOutput is from package DT - recommended to use
)

server <- function(input, output) {
    
    output$table_output <- renderDataTable({
        
        nyc_dogs %>%
            filter(gender == input$gender) #%>%
            #slice(1:10)
    })
    
}

shinyApp(ui = ui, server = server)