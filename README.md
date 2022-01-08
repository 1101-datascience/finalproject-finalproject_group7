# STEM Salaries salary prediction 

## Content
- [Groups](#Groups)
- [Goal](#Goal)
- [Demo](#Demo)
- [Shiny.io](#Shiny.io)
- [Docs](#Docs)
- [Data](#Data)
- [Code](#Code)
- [Results](#Results)
- [Reference](#Reference)


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

```R
# TODO
```

### Shiny.io

* We put our EDA & Model result into shiny app

  ShinyApps link :
  * [randomForest](https://yhqchiu.shinyapps.io/randomForest_shiny/)
  * [...]()



## Folder organization and its related information

### Docs
* docs/xzcxzcz

### Data
* Source
	* Data Science and STEM Salaries 62,000+ STEM salaries scraped from levels.fyi | KAGGLE
	* [Kaggle Breast Cancer Wisconsin](https://www.kaggle.com/jackogozaly/data-science-and-stem-salaries)
* Input format
	* One .csv file.
	* Attribute Information:
		* 1) ID number
		* 2) Diagnosis (M = malignant, B = benign)
		* 3-32) Ten real-valued features are computed for each cell nucleus:
			* a) radius (mean of distances from center to points on the perimeter)
			* b) texture (standard deviation of gray-scale values)
			* c) perimeter
			* d) area
			* e) smoothness (local variation in radius lengths)
			* f) compactness (perimeter^2 / area - 1.0)
			* g) concavity (severity of concave portions of the contour)
			* h) concave points (number of concave portions of the contour)
			* i) symmetry
			* j) fractal dimension ("coastline approximation" - 1)
		* The *mean*, *standard error* and *"worst" or largest* (mean of the threelargest values) of these features were computed for each image, resulting in 30 features. For instance, field 3 is Mean Radius, field 13 is Radius SE, field 23 is Worst Radius.
		* Which is 10 features x 3 measurements = 30 features

* Any preprocessing?
    * 

### Code
* Which method do you use?
    * Robust regression
	* Random forest regression
	* SVM


* What is a null model for comparison?
	* Guess the average salary

* How do your perform evaluation?
	* Cross-validation
	* RMSE


### Results
* Which metric do you use 

* Is your improvement significant?
	* Yes , from xxx to xxx

* What is the challenge part of your project?
    * asd

## Packages
* argparse
* corrplot
* caret
* rpart
* ROCR
* e1071
* randomForest
* Formula
* class
* highcharter
* gbm
* ggbiplot
* ggplot2

## Reference
* [Predicting breast cancer using PCA + LDA in R](https://www.kaggle.com/shravank/predicting-breast-cancer-using-pca-lda-in-r)

* [Breast Cancer or Not](https://www.kaggle.com/mirichoi0218/classification-breast-cancer-or-not-with-15-ml)

* [Decision Trees for Binary Classification](https://www.kaggle.com/paultimothymooney/decision-trees-for-binary-classification-0-99)

* [Statistical Learning Tutorial for Beginners](https://www.kaggle.com/kanncaa1/statistical-learning-tutorial-for-beginners/notebook)

* [Feature Selection - Correlation and P-value](https://www.kaggle.com/bbloggsbott/feature-selection-correlation-and-p-value/data)

* [Breast Cancer Wisconsin (Diagnostic) Data Set](https://www.kaggle.com/uciml/breast-cancer-wisconsin-data/kernels)

* [Random forest: how to handle new factor levels in test set?](https://stats.stackexchange.com/questions/29446/random-forest-how-to-handle-new-factor-levels-in-test-set)

* [R上的CART Package — rpart [參數篇]](https://c3h3notes.wordpress.com/2010/10/25/r%E4%B8%8A%E7%9A%84cart-package-rpart-%E5%8F%83%E6%95%B8%E7%AF%87/)

* [shinythemes](https://shiny.rstudio.com/gallery/shiny-theme-selector.html)
