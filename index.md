# lcda

[![CRAN
status](https://www.r-pkg.org/badges/version/lcda)](https://CRAN.R-project.org/package=lcda)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/grand-total/lcda)](https://cranlogs.r-pkg.org/downloads/total/last-month/lcda)
[![R-CMD-check](https://github.com/mchlbckr/lcda/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mchlbckr/lcda/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/mchlbckr/lcda/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/mchlbckr/lcda/actions/workflows/pkgdown.yaml)

Latent class discriminant analysis for categorical data, including local
and common-components variants.

## Installation

CRAN:

``` r
install.packages("lcda")
```

Development version:

``` r
remotes::install_github("mchlbckr/lcda")
```

## Usage

``` r
library(lcda)

# See ?lcda, ?cclcda, and ?cclcda2 for examples
```

## Overview

Key functions:

- [`lcda()`](https://mchlbckr.github.io/lcda/reference/lcda.md): fits
  separate latent class models per class.
- [`cclcda()`](https://mchlbckr.github.io/lcda/reference/cclcda.md):
  fits a common-components latent class model with class-specific mixing
  proportions.
- [`cclcda2()`](https://mchlbckr.github.io/lcda/reference/cclcda2.md):
  fits a common-components model with class-conditional mixing
  proportions.

Data requirements:

- Manifest variables must be integer-coded and start at 1.
- Grouping labels must be integer-coded and start at 1.

## Documentation

The package includes a vignette with a worked example:

``` r
vignette("lcda")
```

## Reference

Bücker, M., Szepannek, G., Weihs, C. (2010). Local Classification of
Discrete Variables by Latent Class Models. In: Locarek-Junge, H., Weihs,
C. (eds) Classification as a Tool for Research. Studies in
Classification, Data Analysis, and Knowledge Organization. Springer,
Berlin, Heidelberg. <https://doi.org/10.1007/978-3-642-10745-0_13>

Bücker, M. (2008). Lokale Diskrimination diskreter Daten. Diplomarbeit,
Fakultaet Statistik, TU Dortmund.
