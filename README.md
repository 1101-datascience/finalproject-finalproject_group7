# STEM Salaries prediction 

## Content
- [STEM Salaries Prediction](#stem-salaries-salary-prediction)
	- [Content](#content)
		- [Groups](#groups)
		- [Goal](#goal)
		- [Demo](#demo)
		- [Shiny.io](#shinyio)
	- [Folder organization and its related information](#folder-organization-and-its-related-information)
		- [Docs](#docs)
		- [Data](#data)
		- [Code](#code)
		- [Results](#results)
	- [Packages](#packages)
	- [Reference](#reference)


### Groups
| Dept. | Student No. | Name |
| --------- | -------- | -------- |
| 資科碩一 | 110753140 | 張立暘
| 資科三 | 108703017 | 邱彥翔
| 資科碩一 | 110753163 | 林昱辰
| 社會二 | 109204035 | 黃楷捷

### Goal
Our goal is to predict the salary of STEM jobs !

### Demo 
You should provide an example commend to reproduce your result

[Shiny](https://yhqchiu.shinyapps.io/code/)

### Shiny.io

* We put our EDA & Model result into shiny app

  ShinyApps link :
  * [Shiny](https://yhqchiu.shinyapps.io/code/)



## Folder organization and its related information

### Docs
* docs
	* Presentation Slide

### Data
* Source
	* [Data Science and STEM Salaries 62,000+ STEM salaries scraped from levels.fyi | KAGGLE](https://www.kaggle.com/jackogozaly/data-science-and-stem-salaries)
* Input format
	* One .csv file.
	* Attribute Information:
	

* Any preprocessing?
    * drop the NA
    * delete the outlier

### Code
* Which method do you use?
   * Linear regression
   * Decision tree regression
   * Random forest regression
   * SVM
   * XGBtree


* What is a null model for comparison?
	* Guess the median salary

* How do your perform evaluation?
	* Cross-validation
	* MAE


### Results
* Which metric do you use 
	* MAE

* Is your improvement significant?
	* Yes , from 41809.7 to 18185.23

* What is the challenge part of your project?
    * NA值很多，嘗試用KNN來補效果卻不大好
    * Shiny app 呈現會有一些大小的問題，以及無法正確visualization
    * data science的project分工以及merge code是一個大問題


## Packages
* corrplot
* caret
* rpart
* ROCR
* e1071
* randomForest
* Formula
* Metrics
* gbm
* ggbiplot
* ggplot2
* sf
* data.table
* tidyverse
* maps
* repr
* ggthemes
* scales
* ggpubr
* shinythemes
* shiny
* shinydashboard
* cowplot
* rgdal
* e1071
* mlbench
* MLmetrics


## Reference

* [Statistical Learning Tutorial for Beginners](https://www.kaggle.com/kanncaa1/statistical-learning-tutorial-for-beginners/notebook)

* [Feature Selection - Correlation and P-value](https://www.kaggle.com/bbloggsbott/feature-selection-correlation-and-p-value/data)

* [Random forest: how to handle new factor levels in test set?](https://stats.stackexchange.com/questions/29446/random-forest-how-to-handle-new-factor-levels-in-test-set)

* [R上的CART Package — rpart [參數篇]](https://c3h3notes.wordpress.com/2010/10/25/r%E4%B8%8A%E7%9A%84cart-package-rpart-%E5%8F%83%E6%95%B8%E7%AF%87/)

* [ShinyThemes](https://shiny.rstudio.com/gallery/shiny-theme-selector.html)

* [Car Price Prediction](https://rpubs.com/amir761/car_price_prediction_using_random_forest)

* [ML Using R SEction 9 Random Forest](https://rstudio-pubs-static.s3.amazonaws.com/280316_f38c3e4dc75b48398e6e72a20c1ea0a9.html)

* [Correlation coefficient and correlation test in R](https://statsandr.com/blog/correlation-coefficient-and-correlation-test-in-r/)

* [Build your dashboard based on shinydashboard (4) - Karthi softek](https://blog.karthisoftek.com/a?ID=01400-2bcdb5fd-17fc-45d7-b951-b8473a998800)

* [DMA Codes](https://help-ooyala.brightcove.com/sites/all/libraries/dita/en/video-platform/reference/dma_codes.html)

* [Maps with ggplot](http://joshuamccrain.com/tutorials/ggplot_maps/maps_tutorial.html)

* [A Useful DMA Shapefile For #Tableau and #Alteryx](https://datablends.us/2021/01/14/a-useful-dma-shapefile-for-tableau-and-alteryx/)

* [Salary Data EDA] https://www.kaggle.com/jackogozaly/salary-data-eda
* 
* [Salary Data EDA] https://www.kaggle.com/cloudy17/stem-plotly-eda
