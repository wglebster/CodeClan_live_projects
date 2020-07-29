library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinythemes)

all_teams <- unique(olympics_overall_medals$team)
ui <- fluidPage(
    
    theme = shinytheme("flatly"),
    
    titlePanel(tags$i("Olympic Medals")),

    tabsetPanel(
        tabPanel("Plot", 
                 plotOutput("medal_plot")
        ),
        tabPanel("Which Season?",
                 radioButtons("season",
                              "Summer or Winter Olympics?",
                              choices = c("Summer", "Winter")
                            )
                 
                 ),
        tabPanel("Web site",
                 tags$a("Link to Olympics website", href = "https://www.olympic.org/")
    )
)
) 
        
    
#     fluidRow(
#         
#         column(6,
#                radioButtons("season",
#                             "Summer or Winter Olympics?",
#                             choices = c("Summer", "Winter")
#                     )
#     ),
#     
#     column(6,
#            selectInput("team",
#                        "Which Team?",
#                        choices = all_teams
#            )
#         )
#     )
# )
#  




       
        # mainPanel(
        #     plotOutput("medal_plot"),
        #     tags$a("Link to Olympics website", href = "https://www.olympic.org/")
        #     
        # )
    

server <- function(input, output) {
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team == input$team) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col()
    })
}
shinyApp(ui = ui, server = server)





