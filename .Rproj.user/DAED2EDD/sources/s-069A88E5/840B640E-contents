library(shiny)
library(shinydashboard)	
library(ggplot2)
library(shinythemes)
library(ggpubr)
library(corrplot)
library(ggcorrplot)
library(devtools)


# load data
url = "https://raw.githubusercontent.com/1101-datascience/finalproject-finalproject_group7/main/data/train_salary.csv"

data <- read.csv(file = url, header = T, sep = ',',
                 stringsAsFactors = F)
# graph
cor_data <- data
# deal with NA and NULL value, let them be median(num) and mode(char) 
cor_data[is.na(cor_data$dmaid), "dmaid"] <- median(cor_data$dmaid, na.rm = T)

cor_data[is.na(cor_data$Race_Hispanic), "Race_Hispanic"] <- median(cor_data$Race_Hispanic, na.rm = T)

# convert categorical feature to numeric
cor_data$title <- as.numeric(factor(cor_data$title))

cor_data <- subset(cor_data, select = -c(timestamp, company, level, 
                                         location, tag, gender, 
                                         otherdetails, rowNumber,
                                         Race, Education, stockgrantvalue,
                                         totalyearlycompensation, bonus)
                  )
corr <- round(cor(cor_data), 2)
cor_p <- cor_pmat(cor_data)

# laod key feature
raw_data <- data.frame(Base_Salary = data$basesalary,
                       Title = data$title,
                       Years_of_Experience = data$yearsofexperience,
                       Years_at_Company = data$yearsatcompany,
                       City_ID = data$cityid,
                       DMA_Code = data$dmaid,
                       Masters_Degree = data$Masters_Degree,
                       Bachelors_Degree = data$Bachelors_Degree,
                       Doctorate_Degree = data$Doctorate_Degree,
                       Race_Asian = data$Race_Asian,
                       Race_Hispanic = data$Race_Hispanic)

raw_data[is.na(raw_data$DMA_Code), "DMA_Code"] <- median(raw_data$DMA_Code, na.rm = T)

raw_data[is.na(raw_data$Race_Hispanic), "Race_Hispanic"] <- median(raw_data$Race_Hispanic, na.rm = T)

processed_data <- raw_data

data <- na.omit(data)

# =========================== remove outliers ============================
processed_data <- subset(processed_data,
                         processed_data$Base_Salary < 7.5e+05)
processed_data <- subset(processed_data,
                         processed_data$Base_Salary != 0)

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         processed_data$Years_of_Experience <= 40)

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         processed_data$Years_at_Company <= 30)

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         !(processed_data$City_ID > 25000 &
                             processed_data$Base_Salary > 2.5e+05))

processed_data <- subset(processed_data,
                         processed_data$City_ID > 100)

processed_data <- subset(processed_data,
                         !(processed_data$City_ID > 9000 &
                             processed_data$Base_Salary > 4e+05))

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         processed_data$DMA_Code < 1000)

processed_data <- subset(processed_data,
                         !(processed_data$DMA_Code < 750 &
                             processed_data$Base_Salary > 3e+05))

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         !(processed_data$Bachelors_Degree == 1 &
                             processed_data$Base_Salary > 6e+05))

#-----------------------------------------------------------------------

processed_data <- subset(processed_data,
                         !(processed_data$Doctorate_Degree == 1 &
                             processed_data$Base_Salary > 6e+05))
#-----------------------------------------------------------------------

# dashboard
ui <- tagList(
  shinythemes::themeSelector(),
  navbarPage(
    "Deal With Data",
    tabPanel("Correlation",
             mainPanel(
               fluidRow( 
                column(width = 12, align="center", box(plotOutput("Cor"), width = "100%"))
               )
             )
    ),
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
                 column(width = 12, box(plotOutput("Plot"), width = NULL)),	
                 column(width = 12, box(dataTableOutput("Data"), width = NULL))
               )
             )
    ),
    tabPanel("Processed Data",
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
                 column(width = 12, box(plotOutput("Plot2"), width = NULL)),	
                 column(width = 12, box(dataTableOutput("Data2"), width = NULL))
               )
             )
    ),
    tabPanel("Plot_analysis", 
             mainPanel(
               fluidRow(
                 column(width = 12, box(plotOutput("Education_plot"), width = NULL))
                 ),
               fluidRow(
                 column(width = 12, box(plotOutput("Race_plot"), width = NULL))
                 )
               )
             )
        )
      )

server <- function(input, output){
  
  # ============================ Correlation =============================
  
  # correlation graph
  output$Cor <- renderPlot({
    ggcorrplot(corr, hc.order = T, type = "full", p.mat = cor_p,
               ggtheme = ggplot2::theme_classic())
  })
  # ================================ raw =================================
  
  # user select number of raw data
  subset_raw <- reactive({ raw_data[1:input$obs, ] })
  
  # raw scatterplot
  output$Plot <- renderPlot({
    ggscatter(subset_raw(), x = input$x, y = input$y,
              add = "reg.line", cor.method = "pearson",
              xlab = input$x, ylab = input$y) +
      stat_cor(
        aes(label = paste(..rr.label.., ..p.label.., sep = "~','~"))
      )
    
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
              add = "reg.line", cor.method = "pearson",
              xlab = input$x_processed, ylab = input$y_processed) +
      stat_cor(
        aes(label = paste(..rr.label.., ..p.label.., sep = "~','~"))
      )
  })
  
  # ============================ Education ============================
  output$Education_plot <- renderPlot({
    ggplot(data, aes(x = basesalary, y = Education)) +
    geom_point()

  })
  output$Race_plot <- renderPlot({
    ggplot(data, aes(x = basesalary, y = Race)) +
      geom_point()
    
  })

  # ============================== Race ===============================
  
  # processed table data
  data_table_processed = processed_data[sample(1:nrow(processed_data), 10000, replace = T), ]	
  
  # processed table
  output$Data2 <- renderDataTable({	
    head(data_table_processed, input$obs_processed)	
  })
}	
shinyApp(ui, server)

