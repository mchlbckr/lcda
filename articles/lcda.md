# Latent Class Discriminant Analysis

## Overview

The `lcda` package provides latent class discriminant analysis methods
for categorical predictors. The main functions are:

- [`lcda()`](https://mchlbckr.github.io/lcda/reference/lcda.md) for
  class-specific latent class models.
- [`cclcda()`](https://mchlbckr.github.io/lcda/reference/cclcda.md) for
  common-components latent class models.
- [`cclcda2()`](https://mchlbckr.github.io/lcda/reference/cclcda2.md)
  for common-components models with class-conditional mixing weights.

All manifest variables and class labels must be integer-coded and start
at 1.

## Background

The methods in `lcda` implement local discrimination for discrete
variables using latent class analysis (LCA). The key idea is to replace
a single class-conditional distribution with a finite mixture of locally
independent components. This lets each class capture heterogeneity while
keeping the model tractable for categorical data.

Let `K` be the number of classes, `M` the number of latent components,
`D` the number of manifest variables, and `R_d` the number of outcomes
for variable `d`. The indicator `x_dr` equals 1 if variable `d` takes
outcome `r` and 0 otherwise.

## Models

### LCDA (class-specific mixtures)

Each class has its own latent class model:

$$f_{k}(x) = \sum\limits_{m = 1}^{M_{k}}w_{mk}\prod\limits_{d = 1}^{D}\prod\limits_{r = 1}^{R_{d}}\theta_{mkdr}^{x_{dr}}$$

Classification follows the Bayes decision rule:

$$\widehat{k}(x) = \arg\max\limits_{k}\pi_{k}f_{k}(x)$$

### CCLCDA (common components)

Common-components models share the component distributions across
classes, while allowing class-specific mixing weights:

$$f_{k}(x) = \sum\limits_{m = 1}^{M}w_{mk}\prod\limits_{d = 1}^{D}\prod\limits_{r = 1}^{R_{d}}\theta_{mdr}^{x_{dr}}$$

[`cclcda()`](https://mchlbckr.github.io/lcda/reference/cclcda.md) first
estimates the shared LCA on the pooled data and then derives
class-conditional weights.
[`cclcda2()`](https://mchlbckr.github.io/lcda/reference/cclcda2.md)
estimates weights and response probabilities jointly in each EM step.

## Estimation and model selection

Parameter estimation uses the EM algorithm with random starts (see
`nrep`). Model selection can be guided by AIC, BIC, the likelihood ratio
statistic (Gsq), and the Pearson chi-square statistic (Chisq). For
common-components models, additional quality measures are provided:

- Weighted entropy, measuring the purity of latent components.
- Weighted Gini, an alternative impurity measure.
- A chi-square test of independence between latent components and
  classes.

These are reported in the fitted model objects returned by
[`cclcda()`](https://mchlbckr.github.io/lcda/reference/cclcda.md) and
[`cclcda2()`](https://mchlbckr.github.io/lcda/reference/cclcda2.md).

## Example: CCL-CDA2 on Iris

``` r
library(lcda)
#> Loading required package: poLCA
#> Loading required package: scatterplot3d
#> Loading required package: MASS

data(iris)

iris_cat <- within(iris, {
  Sepal.Length <- as.integer(cut(Sepal.Length, breaks = c(-Inf, 5.1, 5.8, 6.4, Inf)))
  Sepal.Width <- as.integer(cut(Sepal.Width, breaks = c(-Inf, 2.8, 3.0, 3.3, Inf)))
  Petal.Length <- as.integer(cut(Petal.Length, breaks = c(-Inf, 1.6, 4.35, 5.1, Inf)))
  Petal.Width <- as.integer(cut(Petal.Width, breaks = c(-Inf, 0.3, 1.3, 1.8, Inf)))
  Species3 <- as.integer(Species)
})

model <- cclcda2(
  Species3 ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
  data = iris_cat,
  m = 1
)

model$bic
#> [1] 1715.472
```

## References

Bücker, M., Szepannek, G., Weihs, C. (2010). Local Classification of
Discrete Variables by Latent Class Models. In: Locarek-Junge, H., Weihs,
C. (eds) Classification as a Tool for Research. Studies in
Classification, Data Analysis, and Knowledge Organization. Springer,
Berlin, Heidelberg. <https://doi.org/10.1007/978-3-642-10745-0_13>

Bücker, M. (2008). Lokale Diskrimination diskreter Daten. Diplomarbeit,
Fakultaet Statistik, TU Dortmund.
