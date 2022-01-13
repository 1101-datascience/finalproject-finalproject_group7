library(sf)
library(maps)
library(rgdal)
library(ggplot2)
library(tidyverse)
library(data.table)

setwd('./dma_boundary')
dma <- readOGR("dma_boundary.shp")
dma.df <- fortify(dma, region = "dma0")
dma.df <- rename(dma.df, DMA = id)

data <- read.csv('Levels_Fyi_Salary_Data.csv')

setDT(data)
new <- data[,dmaid:=as.character(dmaid)][,.(meansalary=mean(basesalary)),by=.(dmaid)]

count <- table(data$dmaid) |> data.frame()

dma.df <- dma.df %>% 
    left_join(count, by = c("DMA" = "Var1"))

dma.df <- dma.df %>% 
    left_join(new, by = c("DMA" = "dmaid"))

ggplot(dma.df, aes(x=long, y=lat, group=group, fill=meansalary)) +
    geom_polygon(color="black", size=.5) +
    scale_fill_gradient(low = "white", high="red") + 
    coord_map() +
    theme_void() +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(legend.position="none") +
    ggtitle("Mean base salary by Designated Market Area (DMA)")

ggplot(dma.df, aes(x=long, y=lat, group=group, fill=Freq)) +
    geom_polygon(color="black", size=.5) +
    scale_fill_gradient(low = "white", high="red") + 
    coord_map() +
    theme_void() +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(legend.position="none") +
    ggtitle("Where they from")

