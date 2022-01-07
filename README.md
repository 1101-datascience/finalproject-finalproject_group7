# STEM Salaries salary prediction 

### Groups
* 張立暘, 110753140
* a
* s
* d

### Goal
Our goal is to predict the salary of STEM jobs !

### Demo 
You should provide an example commend to reproduce your result

```R
# TODO
```

### Shiny.io

* We put our EDA & Model result into shiny app

  ShinyApps link: [https://TODO/]



## Folder organization and its related information

### docs
* docs/xzcxzcz

### data
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

### code
* Which method do you use?
    * Robust regression
	* Random forest regression
	* SVM


* What is a null model for comparison?
	* Guess the average salary

* How do your perform evaluation?
	* Cross-validation
	* RMSE


### results
* Which metric do you use 

* Is your improvement significant?
	* Yes , from xxx to xxx

* What is the challenge part of your project?
    * asd
## Reference
* [Reference 1](https://www.kaggle.com/shravank/predicting-breast-cancer-using-pca-lda-in-r)
* [Reference 2](https://www.kaggle.com/mirichoi0218/classification-breast-cancer-or-not-with-15-ml)
* [Reference 3](https://www.kaggle.com/paultimothymooney/decision-trees-for-binary-classification-0-99)
* [Reference 4](https://www.kaggle.com/kanncaa1/statistical-learning-tutorial-for-beginners/notebook)
* [Reference 5](https://www.kaggle.com/kanncaa1/statistical-learning-tutorial-for-beginners/notebook)
* [Reference 6](https://www.kaggle.com/bbloggsbott/feature-selection-correlation-and-p-value/data)
* [Reference 7](https://www.kaggle.com/uciml/breast-cancer-wisconsin-data/kernels)
* Packages
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
