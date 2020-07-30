library(dygraphs)
ui <- fluidPage(
    dygraphOutput("line_graph")
)
server <- function(input, output) {
    output$line_graph <- renderDygraph({
        dygraph(austres, main = "Australian Residents") 
    })
}
shinyApp(ui, server)