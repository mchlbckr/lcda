# Latent Class Discriminant Analysis (LCDA)

Local Discrimination via Latent Class Models

## Usage

``` r
lcda(x, ...)


# Default S3 method
lcda(x, grouping=NULL, prior=NULL,
                       probs.start=NULL, nrep=1, m=3, 
                       maxiter = 1000, tol = 1e-10,
                       subset, na.rm = FALSE, ...)

# S3 method for class 'formula'
lcda(formula, data, ...)
```

## Arguments

- x:

  Matrix or data frame containing the explanatory variables. Manifest
  variables must contain only integer values, and must be coded with
  integers starting at 1. All missing values should be entered as NA.

- grouping:

  A factor specifying the class for each observation; if not specified,
  the first column of `data` is taken. The class must be coded by
  integer values with consecutive values from 1 to the maximum number of
  classes.

- formula:

  Formula of the form `'groups ~ x1 + x2 + ...'`.

- data:

  Data frame from which variables specified in formula are to be taken.

- prior:

  The prior probabilities of class membership. If unspecified, the class
  proportions for the training set are used. If present, the
  probabilities should be specified in the order of the factor levels.

- probs.start:

  A list (per class) of lists of matrices (per variable) of response
  probabilities \\\theta\_{mkdr}\\ to be used as the starting values for
  the estimation algorithm. Each matrix in the list corresponds to one
  manifest variable, with one row for each latent class, and one column
  for each outcome. The default is `NULL`, producing random starting
  values. Note that if `nrep>1`, then any user-specified `probs.start`
  values are only used in the first of the nrep attempts.

- nrep:

  Number of times to estimate the model, using different random values
  of `probs.start`. The default is one. Setting `nrep>1` automates the
  search for the global – rather than just a local – maximum of the
  log-likelihood function. `lcda` uses the parameter estimates
  corresponding to the model with the greatest log-likelihood.

- m:

  The number of subclasses per class. Can be either a vector containing
  the number of subclasses per class or a number of subclasses for all
  classes. Default is `m=3`.

- maxiter:

  The maximum number of iterations through which the estimation
  algorithm will cycle.

- tol:

  A tolerance value for judging when convergence has been reached. When
  the one-iteration change in the estimated log-likelihood is less than
  `tol`, the estimation algorithm stops updating and considers the
  maximum log-likelihood to have been found.

- subset:

  An index vector specifying the cases to be used in the training
  sample.

- na.rm:

  Logical, for how `lcda` handles cases with missing values on the
  manifest variables. If `TRUE`, those cases are removed (listwise
  deleted) before estimating the model. If `FALSE`, cases with missing
  values are retained. Cases with missing covariates are always removed.
  The default is `TRUE`.

- ...:

  Further arguments to be passed to `lcda`.

## Details

The `lcda`-function performs a Latent Class Discriminant Analysis
(LCDA). A Latent Class Modell will be estimated for each class by the
`poLCA`-function (see
[`poLCA`](https://rdrr.io/pkg/poLCA/man/poLCA.html)). The class
conditional model is given by \$\$f_k(x) = \sum\_{m=1}^{M_k} w\_{mk}
\prod\_{d=1}^D\prod\_{r=1}^{R_d} \theta\_{mkdr}^{x\_{kdr}},\$\$ where
\\k\\ is the class index, \\m\\ is the latent subclass index, \\d\\ is
the variable index and \\r\\ is the observation index. The variable
\\x\_{kdr}\\ is \\1\\ if the variable \\d\\ of this observation is \\r\\
and in class \\k\\. The parameter \\w\_{mk}\\ is the class conditional
mixture weight and \\\theta\_{mkdr}\\ is the probability for outcome
\\r\\ of variable \\d\\ in subclass \\m\\ of class \\k\\.

These Latent Class Models use the assumption of local independence to
estimate a mixture model of latent multi-way tables. The mixture models
are estimated by the EM-algorithm. The number of mixture components
(`m`) is specified by the user. Estimated parameters include the
latent-class conditional response probabilities for each manifest
variable \\\theta\_{mkdr}\\ and the class conditional mixing proportions
\\w\_{mk}\\ denoting the population share of observations corresponding
to each latent multi-way table.

Posterior class probabilities and class memberships can be estimated
with the `predict` method.

## Value

A list of class `lcda` containing the following components:

- call:

  The (matched) function call.

- lca.theta:

  The estimated class conditional response probabilities of the LCA
  given as a list of matrices like `probs.start`.

- lca.w:

  The estimated mixing proportions of the LCA.

- prior:

  Prior probabilites.

- m:

  Number of latent subclasses per class.

- r:

  Number of possible responses per variable.

- k:

  Number of classes.

- d:

  Number of variables.

- aic:

  Value of the AIC for each class conditional Latent Class Model.

- bic:

  Value of the BIC for each class conditional Latent Class Model.

- Gsq:

  The likelihood ratio/deviance statistic for each class conditional
  model.

- Chisq:

  The Pearson Chi-square goodness of fit statistic for fitted vs.
  observed multiway tables for each class conditional model.

## Note

If the number of latent classes per class is unknown a model selection
must be accomplished to determine the value of `m`. For this goal there
are some model selection criteria implemented. The AIC, BIC, likelihood
ratio statistic and the Chi-square goodness of fit statistic are taken
from the poLCA-function (see
[`poLCA`](https://rdrr.io/pkg/poLCA/man/poLCA.html)). For each class
these criteria can be regarded separately and for each class the number
of latent classes can be determined.

## Author

Michael B\\ucker

## See also

[`predict.lcda`](https://mchlbckr.github.io/lcda/reference/predict.lcda.md),
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
object
#> Call:
#> lcda.default(x = data, grouping = grouping, m = 2)
#> 
#> Number of classes:  2 
#> 
#> Prior probabilites:
#> class 1: 0.5 
#> class 2: 0.5 
#> 
#> Number of subclasses:
#> class 1: 2 
#> class 2: 2 
#> 
#> AIC:
#> class 1: 4268.37 
#> class 2: 4298.87 
#> 
#> BIC:
#> class 1: 4373.73 
#> class 2: 4404.23 
#> 
#> Gsq:
#> class 1: 180.78 
#> class 2: 213.84 
#> 
#> Chisq:
#> class 1: 179.86 
#> class 2: 235.77 
```
