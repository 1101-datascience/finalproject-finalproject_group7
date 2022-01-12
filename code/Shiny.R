library(shiny)
library(shinydashboard)	
library(ggplot2)
library(shinythemes)
library(ggpubr)
library(corrplot)
library(ggcorrplot)
library(devtools)
library(tidyverse)
library(scales)
library(ggthemes)
library(repr)
library(sf)



# load data
url = "https://raw.githubusercontent.com/1101-datascience/finalproject-finalproject_group7/main/data/train_salary.csv"

data <- read.csv(file = url, header = T, sep = ',',
                 stringsAsFactors = F)


url_dma = "https://raw.githubusercontent.com/1101-datascience/finalproject-finalproject_group7/main/data/dma.df.csv"

dma.df <-
    read.csv(file = url_dma, header = T, sep = ',', stringsAsFactors = F)
# # graph
# cor_data <- data
# # deal with NA and NULL value, let them be median(num) and mode(char) 
# cor_data[is.na(cor_data$dmaid), "dmaid"] <- median(cor_data$dmaid, na.rm = T)
# 
# cor_data[is.na(cor_data$Race_Hispanic), "Race_Hispanic"] <- median(cor_data$Race_Hispanic, na.rm = T)
# 
# # convert categorical feature to numeric
# cor_data$title <- as.numeric(factor(cor_data$title))
# 
# cor_data <- subset(cor_data, select = -c(timestamp, company, level, 
#                                          location, tag, gender, 
#                                          otherdetails, rowNumber,
#                                          Race, Education, stockgrantvalue,
#                                          totalyearlycompensation, bonus)
# )
# corr <- round(cor(cor_data), 2)
# cor_p <- cor_pmat(cor_data)


select_feat =  c("company", "title", "tag", "basesalary", "gender", "Race", "Education", "yearsofexperience", "yearsatcompany", "cityid", "dmaid")
drop_feat = setdiff(colnames(data),select_feat)

data_cor <- subset(data, select = select_feat)

#drop na
data_cor <- na.omit(data_cor)

#label encoding
for (i in c("company", "title", "tag", "gender", "Race", "Education" )){  
    # print(train[, i])
    data_cor[, i] <- as.numeric(factor(data_cor[, i]))
}


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
                       Race_Hispanic = data$Race_Hispanic,
                       Education = data$Education)

raw_data[is.na(raw_data$DMA_Code), "DMA_Code"] <- median(raw_data$DMA_Code, na.rm = T)

raw_data[is.na(raw_data$Race_Hispanic), "Race_Hispanic"] <- median(raw_data$Race_Hispanic, na.rm = T)

data <- na.omit(data)

a <- unique(data$title)[1:7]
b <- unique(data$title)[8:15]

# dashboard
ui <- tagList(
  shinythemes::themeSelector(),
  navbarPage(
    "Deal With Data",
    
    tabPanel("Raw Data",
             sidebarPanel(
               #            selectInput("x", "Select x axis:", choices = names(raw_data), 
               #                        selected = raw_data$total_yearly_compensation),
               #            selectInput("y", "Select y axis:", choices = names(raw_data), 
               #                        selected = raw_data$base_salary),
               sliderInput("obs", "Number of Data:", min = 0, max = nrow(raw_data),
                           value = 3000, step = 3000, animate = TRUE)
             ),
             mainPanel(
               fluidRow(	
                 #              column(width = 12, box(plotOutput("Plot"), width = NULL)),	
                 column(width = 12, box(dataTableOutput("Data"), width = NULL))
               )
             )
    ),
    
    tabPanel("Correlation",
             mainPanel(
               fluidRow( 
                 column(width = 12, align="center", box(plotOutput("Cor"), width = "100%"))
               )
             )
    ),
    
    tabPanel("EDA",
             sidebarPanel(
               selectInput("x", "Select x axis:", choices = names(raw_data),
                           selected = raw_data$total_yearly_compensation)
               # selectInput("y", "Select y axis:", choices = names(raw_data),
               #             selected = raw_data$base_salary),
             ),
             mainPanel(
               fluidRow(
                 column(width = 12, box(plotOutput("Experience"), width = NULL)),
               ),
               fluidRow(
                 h1("Company Count"),
                 
                 column(width = 12, box(plotOutput("Company"), width = NULL))
               ),
               fluidRow(
                 h1("Title and Base_Salary"),
                 column(width = 12, box(plotOutput("Title_1"), width = NULL)),
                 column(width = 12, box(plotOutput("Title_2"), width = NULL)),
               )
             )
    ),
    tabPanel("DMA & Base_Salary Distribution",
             mainPanel(plotOutput("distPlot1"),plotOutput("distPlot2"))
    )
  )
)

server <- function(input, output){
  
  # ============================ Correlation =============================
  
  # correlation graph
  output$Cor <- renderPlot({
    corrplot(cor(data_cor),
             method = "shade",
             type = "full",
             number.cex=0.75
    )
  })
  # ================================ raw =================================
  
  # # user select number of raw data
  # subset_raw <- reactive({ raw_data[1:input$obs, ] })
  # 
  # # raw scatterplot
  # output$Plot <- renderPlot({
  #   ggscatter(subset_raw(), x = input$x, y = input$y,
  #             add = "reg.line", cor.method = "pearson",
  #             xlab = input$x, ylab = input$y) +
  #     stat_cor(
  #       aes(label = paste(..rr.label.., ..p.label.., sep = "~','~"))
  #     )
  #   
  # })
  
  # raw table data
  data_table_raw = raw_data[sample(1:nrow(raw_data), 10000, replace = T), ]	
  
  # raw table
  output$Data <- renderDataTable({	
    head(data_table_raw, input$obs)	
  })
  
  # ============================ Company ============================
  
  output$Experience <- renderPlot({
    #Salary for Data By YOE and Race 
    raw_data %>% 
      filter(Title== "Data Scientist")%>% 
      drop_na(Education) %>% 
      ggplot() + aes(y=round(Base_Salary/10000)*10000 , x= get(input$x), group= Education, color= Education) + geom_point(size=3) + 
      scale_y_continuous(labels=scales::dollar_format()) + theme_fivethirtyeight(base_size=20) + 
      theme(axis.title = element_text(size=15, face='bold'),
            axis.text= element_text(size=12), plot.title = element_text(hjust=.5),legend.text = element_text(size=12), 
            legend.title = element_text(size=12)) + ylab("\n Base salary") + xlab(input$x) + 
      ggtitle("Data Scientist Base salary Years of Experience")+ guides(colour = guide_legend(override.aes = list(size=6)))
  })
  
  output$Company <- renderPlot({
    data %>% 
      count(company, sort= T) %>%
      head(n=15) %>% 
      ggplot() + aes(x= reorder(company, n), y=n) + geom_col(fill='#0E158E') +
      theme_fivethirtyeight(base_size=12) + theme(plot.title= element_text(hjust = .5), 
                                                  axis.title = element_text(size=15, face='bold'),
                                                  axis.text= element_text(size=12)) + 
      ylab("\n Count") + xlab("Company\n") +
      ggtitle("Number of Salaries Recorded Per Company") +
      guides(colour = guide_legend(override.aes = list(size=6))) +
      scale_y_continuous(labels=comma)
  })
  
  output$Title_1 <- renderPlot({
    ggplot(data[(data$title %in% a),], aes(x = as.factor(title), y = basesalary, color = as.factor(title))) +
      geom_boxplot() +
      guides(colour = guide_legend(override.aes = list(size=6))) +
      xlab("title") +
      ylab("basesalary")
  })
  output$Title_2 <- renderPlot({
    ggplot(data[(data$title %in% b),], aes(x = as.factor(title), y = basesalary, color = as.factor(title))) +
      geom_boxplot() +
      guides(colour = guide_legend(override.aes = list(size=6))) + 
      xlab("title") +
      ylab("basesalary")
  })
  
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

shinyApp(ui, server)
=======
    shinythemes::themeSelector(),
    navbarPage(
        "Deal With Data",
        
        tabPanel("Raw Data",
                 sidebarPanel(
                     #            selectInput("x", "Select x axis:", choices = names(raw_data), 
                     #                        selected = raw_data$total_yearly_compensation),
                     #            selectInput("y", "Select y axis:", choices = names(raw_data), 
                     #                        selected = raw_data$base_salary),
                     sliderInput("obs", "Number of Data:", min = 0, max = nrow(raw_data),
                                 value = 3000, step = 3000, animate = TRUE)
                 ),
                 mainPanel(
                     fluidRow(	
                         #              column(width = 12, box(plotOutput("Plot"), width = NULL)),	
                         column(width = 12, box(dataTableOutput("Data"), width = NULL))
                     )
                 )
        ),
        
        tabPanel("Correlation",
                 mainPanel(
                     fluidRow( 
                         column(width = 12, align="center", box(plotOutput("Cor"), width = "100%"))
                     )
                 )
        ),
        
        tabPanel("EDA",
                 sidebarPanel(
                     selectInput("x", "Select x axis:", choices = names(raw_data),
                                 selected = raw_data$total_yearly_compensation)
                     # selectInput("y", "Select y axis:", choices = names(raw_data),
                     #             selected = raw_data$base_salary),
                 ),
                 mainPanel(
                     fluidRow(
                         column(width = 12, box(plotOutput("Experience"), width = NULL)),
                     ),
                     fluidRow(
                         column(width = 12, box(plotOutput("Company"), width = NULL))
                     ),
                     fluidRow(
                         column(width = 12, box(plotOutput("Title_1"), width = NULL)),
                         column(width = 12, box(plotOutput("Title_2"), width = NULL)),
                     )
                 )
        ),
        tabPanel("DMA & Base_Salary Distribution",
                 mainPanel(plotOutput("distPlot1"),plotOutput("distPlot2"))
        )
    )
)

server <- function(input, output){
    
    # ============================ Correlation =============================
    
    # correlation graph
    output$Cor <- renderPlot({
        corrplot(cor(data_cor),
                 method = "shade",
                 type = "full",
                 number.cex=0.75
        )
    })
    # ================================ raw =================================
    
    # # user select number of raw data
    # subset_raw <- reactive({ raw_data[1:input$obs, ] })
    # 
    # # raw scatterplot
    # output$Plot <- renderPlot({
    #   ggscatter(subset_raw(), x = input$x, y = input$y,
    #             add = "reg.line", cor.method = "pearson",
    #             xlab = input$x, ylab = input$y) +
    #     stat_cor(
    #       aes(label = paste(..rr.label.., ..p.label.., sep = "~','~"))
    #     )
    #   
    # })
    
    # raw table data
    data_table_raw = raw_data[sample(1:nrow(raw_data), 10000, replace = T), ]	
    
    # raw table
    output$Data <- renderDataTable({	
        head(data_table_raw, input$obs)	
    })
    
    # ============================ Company ============================
    
    output$Experience <- renderPlot({
        #Salary for Data By YOE and Race 
        raw_data %>% 
            filter(Title== "Data Scientist")%>% 
            drop_na(Education) %>% 
            ggplot() + aes(y=round(Base_Salary/10000)*10000 , x= get(input$x), group= Education, color= Education) + geom_point(size=3) + 
            scale_y_continuous(labels=scales::dollar_format()) + theme_fivethirtyeight(base_size=20) + 
            theme(axis.title = element_text(size=15, face='bold'),
                  axis.text= element_text(size=12), plot.title = element_text(hjust=.5),legend.text = element_text(size=12), 
                  legend.title = element_text(size=12)) + ylab("\n Base salary") + xlab(input$x) + 
            ggtitle("Data Scientist Base salary Years of Experience")+ guides(colour = guide_legend(override.aes = list(size=6)))
    })
    
    output$Company <- renderPlot({
        data %>% 
            count(company, sort= T) %>%
            head(n=15) %>% 
            ggplot() + aes(x= reorder(company, n), y=n) + geom_col(fill='#0E158E') +
            theme_fivethirtyeight(base_size=12) + theme(plot.title= element_text(hjust = .5), 
                                                        axis.title = element_text(size=15, face='bold'),
                                                        axis.text= element_text(size=12)) + 
            ylab("\n Count") + xlab("Company\n") + labs(title = "Company Count") +
            ggtitle("Number of Salaries Recorded Per Company") +
            guides(colour = guide_legend(override.aes = list(size=6))) +
            scale_y_continuous(labels=comma)
    })
    
    output$Title_1 <- renderPlot({
        ggplot(data[(data$title %in% a),], aes(x = as.factor(title), y = basesalary, color = as.factor(title))) +
            geom_boxplot() +
            ggtitle("Title and Base_Salary") +
            guides(colour = guide_legend(override.aes = list(size=6))) +
            xlab("title") +
            ylab("basesalary")
    })
    output$Title_2 <- renderPlot({
        ggplot(data[(data$title %in% b),], aes(x = as.factor(title), y = basesalary, color = as.factor(title))) +
            geom_boxplot() +
            ggtitle("Title and Base_Salary") +
            guides(colour = guide_legend(override.aes = list(size=6))) + 
            xlab("title") +
            ylab("basesalary")
    })
    
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

shinyApp(ui, server)
>>>>>>> 66b2de6b4b089732c2285769581bb0716fcde953
