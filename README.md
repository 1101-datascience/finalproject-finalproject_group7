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
  *rpart
