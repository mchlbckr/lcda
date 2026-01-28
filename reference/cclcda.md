# Common Components Latent Class Discriminant Analysis (CCLCDA)

Local Discrimination via Latent Class Models with common components.

## Usage

``` r
cclcda(x, ...)


# Default S3 method
cclcda(x, grouping=NULL, prior=NULL,
                         probs.start=NULL, nrep=1, m=3, 
                         maxiter = 1000, tol = 1e-10,
                         subset, na.rm = FALSE, ...)

# S3 method for class 'formula'
cclcda(formula, data, ...)
```

## Arguments

- x:

  Matrix or data frame containing the explanatory variables. Manifest
  variables must contain only integer values, and must be coded with
  integers starting at 1. All missing values should be entered as NA.

- grouping:

  A factor specifying the class for each observation; if not specified,
  the first column of 'data' is taken. The class must be coded by
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

  A list of matrices (per variable) of response probabilities
  \\\theta\_{mkdr}\\ to be used as the starting values for the
  estimation algorithm. Each matrix in the list corresponds to one
  manifest variable, with one row for each latent class, and one column
  for each outcome. The default is `NULL`, producing random starting
  values. Note that if `nrep>1`, then any user-specified `probs.start`
  values are only used in the first of the nrep attempts.

- nrep:

  Number of times to estimate the model, using different random values
  of `probs.start`. The default is one. Setting `nrep>1` automates the
  search for the global – rather than just a local – maximum of the
  log-likelihood function. `cclcda` uses the parameter estimates
  corresponding to the model with the greatest log-likelihood.

- m:

  The number of subclasses. Can be either a vector containing the number
  of subclasses per class or a number of subclasses for all classes.
  Default is `m=3`.

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

  Logical, for how `cclcda` handles cases with missing values on the
  manifest variables. If `TRUE`, those cases are removed (listwise
  deleted) before estimating the model. If `FALSE`, cases with missing
  values are retained. Cases with missing covariates are always removed.
  The default is `TRUE`.

- ...:

  Further arguments to be passed to `cclcda.default`.

## Details

The `cclcda`-function performs a Common Components Latent Class
Discriminant Analysis (CCLCDA). The model to estimate is \$\$f(x) =
\sum\_{m=1}^{M} w\_{m} \prod\_{d=1}^D\prod\_{r=1}^{R_d}
\theta\_{mdr}^{x\_{dr}},\$\$ where \\m\\ is the latent subclass index,
\\d\\ is the variable index and \\r\\ is the observation index. The
variable \\x\_{dr}\\ is \\1\\ if the variable \\d\\ of this observation
is \\r\\. This common Latent Class Modell will be estimated for all
classes by the `poLCA`-function (see
[`poLCA`](https://rdrr.io/pkg/poLCA/man/poLCA.html)) and class
conditional mixing proportions \\w\_{mk}\\ are computed afterwards.
These weights are computed by \$\$\frac{1}{N_k}
\sum\_{n=1}^{N_k}\hat{P}(m, k\|X=x_n),\$\$ where \\k\\ is the class
index and \\N_k\\ the number of observations in class \\k\\.

The LCA uses the assumption of local independence to estimate a mixture
model of latent multi-way tables, the number of which (`m`) is specified
by the user. Estimated parameters include the latent-class-conditional
response probabilities for each manifest variable \\\theta\_{mdr}\\ and
the class conditional mixing proportions \\w\_{mk}\\ denoting population
share of observations corresponding to each latent multi-way table per
class.

Posterior class probabilities can be estimated with the `predict`
method.

## Value

A list of class `cclcda` containing the following components:

- call:

  The (matched) function call.

- lca.theta:

  The estimated class conditional response probabilities of the LCA
  given as a list of matrices like `probs.start`.

- lca.w:

  The estimated mixing proportions of the LCA.

- lca.wmk:

  The estimated class conditional mixing proportions of the LCA.

- prior:

  Prior probabilites.

- m:

  Number of latent subclasses.

- r:

  Number of different responses per variable.

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

- entropy:

  Value of the weighted entropy as described below.

- gini:

  Value of the weighted Gini coefficient as described below.

- chi.stat:

  Value of the Chi-square test statistik of the test of latent class
  membership and class membership as described below.

- chi.p:

  P Value of the Chi-square of the test of latent class membership and
  class membership as described below.

## Note

If the number of latent classes per class is unknown a model selection
must be accomplished to determine the value of `m`. For this goal there
are some model selection criteria implemented. The AIC, BIC, likelihood
ratio statistic and the Chi-square goodness of fit statistic are taken
from the poLCA-function (see
[`poLCA`](https://rdrr.io/pkg/poLCA/man/poLCA.html)).

Additionally `cclcda` provides quality criteria which should give
insight into the model's classification potential. These criteria are
similar to the splitting criteria of classification trees. The impurity
measures are

– Weighted entropy: The weighted entropy is given by \$\$H := -
\sum\_{m=1}^M P(m) \sum\_{k=1}^K \left(P(k\|m) \cdot
\log\_{K}{P(k\|m)}\right).\$\$

– Weighted Gini coefficient: The weighted Gini coefficient is given by
\$\$G := \sum\_{m=1}^M P(m) \left\[ 1- \sum\_{k=1}^{K} \left( P(k\|m)
\right)^2 \right\].\$\$

– Pearson's Chi-square test: A Pearson's Chi-square test is performed to
test the independence of latent class membership and class membership.

## Author

Michael B\\ucker

## See also

[`predict.cclcda`](https://mchlbckr.github.io/lcda/reference/predict.cclcda.md),
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
 data <- data_temp$dat + 1
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
 data.test <- data_temp$dat + 1
lclass <- data_temp$trueclass
grouping.test <- numeric()
for (i in 1:length(lclass))
{
grouping.test[i] <- sample(c(1,2),1, prob=wkm[,lclass[i]])
}

# cclcda-procedure
object <- cclcda(data, grouping, m=4)
object
#> Call:
#> cclcda.default(x = data, grouping = grouping, m = 4)
#> 
#> Number of classes:  2 
#> 
#> Prior probabilites:
#> class 1: 0.47 
#> class 2: 0.53 
#> 
#> Number of latent classes:  4 
#> 
#> AIC:  9808.12 
#> 
#> BIC:  10136.94 
#> 
#> Gsq:  216.65 
#> 
#> Chisq:  188.07 
#> 
#> Entropy:  0.71 
#> 
#> Gini:  0.31 
#> 
#> Chisq-statistic:  369.4 
#> 
#> Chisq p-value:  0 
```
