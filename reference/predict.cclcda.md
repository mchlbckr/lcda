# Predict method for Common Components Latent Class Discriminant Analysis (CCLCDA)

Classifies new observations using parameters determined by the
`cclcda`-function.

## Usage

``` r
# S3 method for class 'cclcda'
predict(object, newdata, ...)
```

## Arguments

- object:

  Object of class `cclcda`.

- newdata:

  Data frame of cases to be classified.

- ...:

  Further arguments are ignored.

## Details

Posterior probabilities for new observations using parameters determined
by the `cclcda`-function are computed. The classification of the new
data is done by the Bayes decision function.

## Value

A list with components:

- class:

  Vector (of class `factor`) of classifications.

- posterior:

  Posterior probabilities for the classes. For details of computation
  see [`cclcda`](https://mchlbckr.github.io/lcda/reference/cclcda.md).

## Author

Michael B\\ucker

## See also

[`cclcda`](https://mchlbckr.github.io/lcda/reference/cclcda.md),
[`lcda`](https://mchlbckr.github.io/lcda/reference/lcda.md),
[`predict.lcda`](https://mchlbckr.github.io/lcda/reference/predict.lcda.md),
[`cclcda2`](https://mchlbckr.github.io/lcda/reference/cclcda2.md),
[`predict.cclcda2`](https://mchlbckr.github.io/lcda/reference/predict.cclcda2.md),
[`poLCA`](https://rdrr.io/pkg/poLCA/man/poLCA.html)

## Examples

``` r
# response probabilites
probs1 <- list()

probs1[[1]] <- matrix(c(0.7,0.1,0.1,0.1,0.1,0.7,0.1,0.1,
                        0.1,0.1,0.7,0.1,0.1,0.1,0.1,0.7), 
                      nrow=4, byrow=TRUE)
probs1[[2]] <- matrix(c(0.1,0.7,0.1,0.1,0.1,0.1,0.7,0.1,
                        0.1,0.1,0.1,0.7,0.7,0.1,0.1,0.1),
                      nrow=4, byrow=TRUE)
probs1[[3]] <- matrix(c(0.1,0.1,0.7,0.1,0.1,0.1,0.1,0.7,
                        0.7,0.1,0.1,0.1,0.1,0.7,0.1,0.1),
                      nrow=4, byrow=TRUE)
probs1[[4]] <- matrix(c(0.1,0.1,0.1,0.7,0.7,0.1,0.1,0.1,
                        0.1,0.7,0.1,0.1,0.1,0.1,0.7,0.1),
                      nrow=4, byrow=TRUE)

prior <- c(0.5,0.5)
wmk <- matrix(c(0.45,0.45,0.05,0.05,0.05,0.05,0.45,0.45),
              ncol=4, nrow=2, byrow=TRUE)
wkm <- apply(wmk*prior, 2, function(x) x/sum(x))

# generation of training data
data_temp <- poLCA.simdata(N = 1000, probs = probs1,
                           nclass = 2, ndv = 4, nresp = 4,
                           P=rep(0.25,4))
data <- data_temp$dat
lclass <- data_temp$trueclass
grouping <- numeric()
for (i in 1:length(lclass))
{
grouping[i] <- sample(c(1,2),1, prob=wkm[,lclass[i]])
}

# generation of test data
data_temp <- poLCA.simdata(N = 500, probs = probs1,
                           nclass = 2, ndv = 4, nresp = 4,
                           P=rep(0.25,4))
data.test <- data_temp$dat
lclass <- data_temp$trueclass
grouping.test <- numeric()
for (i in 1:length(lclass))
{
grouping.test[i] <- sample(c(1,2),1, prob=wkm[,lclass[i]])
}

# cclcda-procedure
object <- cclcda(data, grouping, m=4)
pred <- predict(object, data.test)$class
1-(sum(pred==grouping.test)/500)
#> [1] 0.16
```
