library(shiny)
library(tidyverse)
library(CodeClanData)

# UI section
ui <- fluidPage(
    
    titlePanel("Medals by Teams"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("seasons", 
                         "Select season:", 
                         choices = c("Summer", "Winter")),
            radioButtons("medals",
                         "Select medal:",
                         choices = c("Gold", "Silver", "Bronze"))
        ),
        
        mainPanel(
            plotOutput("medal_plot"),
            tableOutput("medal_table")
        )
    )
)

# Server section
server <- function(input, output) {
   # browser()
  filtered_data <- reactive({
    olympics_overall_medals %>%
    filter(team %in% c("United States","Soviet Union","Germany","Italy","Great Britain")) %>%
    filter(medal == input$medals) %>%
    filter(season == input$seasons)
  })
  
  output$medal_plot <- renderPlot({
                ggplot(filtered_data()) +
                geom_col(aes(x = team, y = count))
    })
      
      output$medal_table <- renderTable({
        filtered_data()
      })
}

# Run the app
shinyApp(ui = ui, server = server)