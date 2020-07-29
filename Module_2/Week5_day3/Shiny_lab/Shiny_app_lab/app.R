library(shiny)
library(tidyverse)
library(CodeClanData)

# UI section
ui <- fluidPage(
    
    titlePanel("Medals by Teams"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("season", 
                         "Select season:", 
                         choices = c("Summer", "Winter")),
            radioButtons("medal",
                         "Select medal:",
                         choices = c("Gold", "Silver", "Bronze"))
        ),
        
        mainPanel(
            plotOutput("medal_plot")
        )
    )
)

# Server section
server <- function(input, output) {
    output$medal_plot <- renderPlot({
        
             olympics_overall_medals %>%
                filter(team %in% c("United States",
                                   "Soviet Union",
                                   "Germany",
                                   "Italy",
                                   "Great Britain")) %>%
                filter(medal == input$medal) %>%
                filter(season == input$season) %>%
                ggplot() +
                aes(x = team, y = count) +
                geom_col()
        })
}

# Run the app
shinyApp(ui = ui, server = server)