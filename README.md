# RandomForest Predict Base_Salary


## Code
```R
Rscript randomForest.R --fold N --train ds_final/train_salary.csv --test ds_final/test_salary.csv --report performance.csv --predict predict.csv
```


## Reference
[Car Price Prediction](https://rpubs.com/amir761/car_price_prediction_using_random_forest)

[ML Using R SEction 9 Random Forest](https://rstudio-pubs-static.s3.amazonaws.com/280316_f38c3e4dc75b48398e6e72a20c1ea0a9.html)

[Correlation coefficient and correlation test in R](https://statsandr.com/blog/correlation-coefficient-and-correlation-test-in-r/)

# ======================

# Rpart(Decision tree) Predict Base_Salary

### Example commend
```R
Rscript rpart.R --fold 5 --train train_salary.csv --test test_salary.csv --report result/rpart_performance.csv --predict result/rpart_predict.csv
```

### results

* Metric: RMSE

## References
* Code/implementation which you include/reference
  * [Random forest: how to handle new factor levels in test set?](https://stats.stackexchange.com/questions/29446/random-forest-how-to-handle-new-factor-levels-in-test-set)
  * [R上的CART Package — rpart [參數篇]](https://c3h3notes.wordpress.com/2010/10/25/r上的cart-package-rpart-參數篇/)
* Packages
  * rpart
