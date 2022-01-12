dma.df <- read.csv(file = 'dma.df.csv', header = T, sep = ',', stringsAsFactors = F) 

ggplot()+
    geom_polygon(data=dma.df,aes(x=long,y=lat,group=group,fill=meansalary))+
    scale_fill_viridis_c(option = "B",direction = -1,name="Mean Base Salary")+
    theme_void()+
    labs(title ="Mean base salary by Designated Market Area (DMA)")+
    theme(plot.title = element_text(size=20,hjust = 0.5),
          legend.position = c(0.95,0.4))
