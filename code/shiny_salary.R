library(shiny)
library(sf)
library(ggplot2)

# Define UI for application that draws a histogram
ui <-
    fluidPage(titlePanel("110-1 Data Science feature visualization"),
              
              # Show a plot of the generated distribution
              mainPanel(plotOutput("distPlot1"),plotOutput("distPlot2")))

# Define server logic required to draw a histogram
server <- function(input, output) {
    url = "https://raw.githubusercontent.com/1101-datascience/finalproject-finalproject_group7/main/data/dma.df.csv"
    dma.df <-
        read.csv(
            file = url,
            header = T,
            sep = ',',
            stringsAsFactors = F
        )
    
    output$distPlot1 <- renderPlot({
        ggplot() +
            geom_polygon(data = dma.df,
                         aes(
                             x = long,
                             y = lat,
                             group = group,
                             fill = meansalary
                         )) +
            scale_fill_viridis_c(option = "B",
                                 direction = -1,
                                 name = "Average Base Salary") +
            theme_void() +
            labs(title = "Average base salary by Designated Market Area (DMA)") +
            theme(
                plot.title = element_text(size = 20, hjust = 0.5),
                legend.position = c(0.93, 0.4)
            )
    })
    output$distPlot2 <- renderPlot({
        ggplot() +
            geom_polygon(data = dma.df,
                         aes(
                             x = long,
                             y = lat,
                             group = group,
                             fill = Freq
                         )) +
            scale_fill_viridis_c(option = "B",
                                 direction = -1,
                                 name = "Sample size") +
            theme_void() +
            labs(title = "Number of sample by Designated Market Area (DMA)") +
            theme(
                plot.title = element_text(size = 20, hjust = 0.5),
                legend.position = c(0.95, 0.4)
            )
    })
}
# Run the application
shinyApp(ui = ui, server = server)
