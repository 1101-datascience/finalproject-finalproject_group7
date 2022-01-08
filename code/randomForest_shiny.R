library(shiny)	
library(shinydashboard)	
library(ggplot2)
library(shinythemes)
library(ggpubr)


# load data
data <- read.csv(file = "ds_final/train_salary.csv", header = T, stringsAsFactors = F) 

# laod key feature
raw_data <- data.frame(base_salary = data$basesalary,
                       title = data$title,
                       years_of_experience = data$yearsofexperience,
                       years_at_company = data$yearsatcompany,
                       city_ID = data$cityid,
                       dmaid = data$dmaid,
                       Bachelors_degree = data$Bachelors_Degree,
                       Doctorate_degree = data$Doctorate_Degree
)
raw_data[is.na(raw_data$dmaid), "dmaid"] <- median(raw_data$dmaid, na.rm = T)
# convert categorical feature to numeric
merge$title <- as.numeric(factor(merge$title))

processed_data <- raw_data

# =========================== remove outliers ============================
processed_data <- subset(processed_data,
                         processed_data$base_salary < 7.5e+05)
processed_data <- subset(processed_data,
                         processed_data$base_salary != 0)

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         processed_data$years_of_experience <= 40)

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         processed_data$years_at_company <= 30)

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         !(processed_data$city_ID > 25000 &
                             processed_data$base_salary > 2.5e+05))

processed_data <- subset(processed_data,
                         processed_data$city_ID > 100)

processed_data <- subset(processed_data,
                         !(processed_data$city_ID > 9000 &
                             processed_data$base_salary > 4e+05))

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         processed_data$dmaid < 1000)

processed_data <- subset(processed_data,
                         !(processed_data$dmaid < 750 &
                             processed_data$base_salary > 3e+05))

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         !(processed_data$Bachelors_degree == 1 &
                             processed_data$base_salary > 6e+05))

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         !(processed_data$Doctorate_degree == 1 &
                             processed_data$base_salary > 6e+05))
#-----------------------------------------------------------------------

# dashboard
ui <- tagList(
  shinythemes::themeSelector(),
  navbarPage(
    "Remove Outlier",
    tabPanel("Raw Data",
             sidebarPanel(
               selectInput("x", "Select x axis:", choices = names(raw_data), 
                           selected = raw_data$total_yearly_compensation),
               selectInput("y", "Select y axis:", choices = names(raw_data), 
                           selected = raw_data$base_salary),
               sliderInput("obs", "Number of Data:", min = 0, max = nrow(raw_data),
                           value = 3000, step = 3000, animate = TRUE)
             ),
             mainPanel(
               fluidRow(	
                 column(width = 12,box(plotOutput("Plot"), width = NULL)),	
                 column(width = 12,box(dataTableOutput("Data"), width = NULL))
               )
             )
    ),
    tabPanel("processed data"),
    sidebarPanel(
      selectInput("x_processed", "Select x axis:", choices = names(processed_data), 
                  selected = processed_data$total_yearly_compensation),
      selectInput("y_processed", "Select y axis:", choices = names(processed_data), 
                  selected = processed_data$base_salary),
      sliderInput("obs_processed", "Number of Data:", min = 0, max = nrow(processed_data),
                  value = 1000, step = 1000, animate = TRUE)
    ),
    mainPanel(
      fluidRow(	
        column(width = 12,box(plotOutput("Plot2"), width = NULL)),	
        column(width = 12,box(dataTableOutput("Data2"), width = NULL))
      )
    )
  )
)

server <- function(input, output){
  
  # ================================ raw =================================
  
  # user select number of raw data
  subset_raw <- reactive({ raw_data[1:input$obs, ] })
  
  # raw scatterplot
  output$Plot <- renderPlot({
    ggscatter(subset_raw(), x = input$x, y = input$y,
              add = "reg.line", conf.int = TRUE,
              cor.coef = TRUE, cor.method = "pearson",
              xlab = input$x, ylab = input$y)
  })
  
  # raw table data
  data_table_raw = raw_data[sample(1:nrow(raw_data), 10000, replace = T), ]	
  
  # raw table
  output$Data <- renderDataTable({	
    head(data_table_raw, input$obs)	
  })
  # =============================== processed ===============================
  
  # user select number of processed data
  subset_processed <- reactive({ processed_data[1:input$obs_processed, ] })
  
  # processed scatterplot
  
  output$Plot2 <- renderPlot({
    ggscatter(subset_processed(), x = input$x_processed, y = input$y_processed,
              add = "reg.line", conf.int = TRUE,
              cor.coef = TRUE, cor.method = "pearson",
              xlab = input$x_processed, ylab = input$x_processed)
  })
  
  # processed table data
  data_table_processed = processed_data[sample(1:nrow(processed_data), 10000, replace = T), ]	
  
  # processed table
  output$Data2 <- renderDataTable({	
    head(data_table_processed, input$obs_processed)	
  })
}	
shinyApp(ui, server)
