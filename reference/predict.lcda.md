# Predict method for Latent Class Discriminant Analysis (LCDA)

Classifies new observations using the parameters determined by the
`lcda`-function.

## Usage

``` r
# S3 method for class 'lcda'
predict(object, newdata, ...)
```

## Arguments

- object:

  Object of class `lcda2`.

- newdata:

  Data frame of cases to be classified.

- ...:

  Further arguments are ignored.

## Details

Posterior probabilities for new observations using parameters determined
by the `lcda`-function are computed. The classification of the new data
is done by the Bayes decision function.

## Value

A list with components:

- class:

  Vector (of class `factor`) of classifications.

- posterior:

  Posterior probabilities for the classes. For details of computation
  see [`lcda`](https://mchlbckr.github.io/lcda/reference/lcda.md).

## Author

Michael B\\ucker

## See also

[`lcda`](https://mchlbckr.github.io/lcda/reference/lcda.md),
[`cclcda`](https://mchlbckr.github.io/lcda/reference/cclcda.md),
[`predict.cclcda`](https://mchlbckr.github.io/lcda/reference/predict.cclcda.md),
[`cclcda2`](https://mchlbckr.github.io/lcda/reference/cclcda2.md),
[`predict.cclcda2`](https://mchlbckr.github.io/lcda/reference/predict.cclcda2.md),
[`poLCA`](https://rdrr.io/pkg/poLCA/man/poLCA.html)

## Examples

``` r
# response probabilites for class 1
probs1 <- list()
probs1[[1]] <- matrix(c(0.7,0.1,0.1,0.1,0.1,0.7,0.1,0.1), 
                      nrow=2, byrow=TRUE)
probs1[[2]] <- matrix(c(0.1,0.7,0.1,0.1,0.1,0.1,0.7,0.1),
                      nrow=2, byrow=TRUE)
probs1[[3]] <- matrix(c(0.1,0.1,0.7,0.1,0.1,0.1,0.1,0.7),
                      nrow=2, byrow=TRUE)
probs1[[4]] <- matrix(c(0.1,0.1,0.1,0.7,0.7,0.1,0.1,0.1),
                      nrow=2, byrow=TRUE)

# response probabilites for class 2
probs2 <- list()
probs2[[1]] <- matrix(c(0.1,0.1,0.7,0.1,0.1,0.1,0.1,0.7),
                      nrow=2, byrow=TRUE)
probs2[[2]] <- matrix(c(0.1,0.1,0.1,0.7,0.7,0.1,0.1,0.1),
                      nrow=2, byrow=TRUE)
probs2[[3]] <- matrix(c(0.7,0.1,0.1,0.1,0.1,0.7,0.1,0.1),
                      nrow=2, byrow=TRUE)
probs2[[4]] <- matrix(c(0.1,0.7,0.1,0.1,0.1,0.1,0.7,0.1),
                      nrow=2, byrow=TRUE)

# generation of data
simdata1 <- poLCA.simdata(N = 500, probs = probs1, nclass = 2,
              ndv = 4, nresp = 4, missval = FALSE)

simdata2 <- poLCA.simdata(N = 500, probs = probs2, nclass = 2,
              ndv = 4, nresp = 4, missval = FALSE)

data1 <- simdata1$dat
data2 <- simdata2$dat

data <- cbind(rbind(data1, data2), rep(c(1,2), each=500))
names(data)[5] <- "grouping"
data <- data[sample(1:1000),]
grouping <- data[[5]]
data <- data[,1:4]

# lcda-procedure
object <- lcda(data, grouping=grouping, m=2)
pred.class <- predict(object, newdata=data)$class
sum(pred.class==grouping)/length(pred.class)
#> [1] 0.928
```
