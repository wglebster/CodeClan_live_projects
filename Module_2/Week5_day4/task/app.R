library(CodeClanData)
library(dplyr)
library(ggplot2)
library(shiny)

#add a (data) table


all_teams <- unique(olympics_overall_medals$team)
ui <- fluidPage(
    titlePanel("Olympic Medals"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("season",
                         "Summer or Winter Olympics?",
                         choices = c("Summer", "Winter")
            ),
            selectInput("team",
                        "Which Team?",
                        choices = all_teams,
                        selected = "Great Britain"
            ),
            actionButton("update", "Show medals"),
        ),
        mainPanel(
            plotOutput("medal_data")
        )
    )
)
server <- function(input, output) {
    
    medal_data <- eventReactive(input$update, {
        olympics_overall_medals %>%
            filter(team == input$team) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = medal, y = count, fill = medal) +
            geom_col()
    })
    output$medal_data <- renderPlot({
        medal_data()
    })
}
shinyApp(ui = ui, server = server)