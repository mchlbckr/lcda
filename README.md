# lcda

Latent class discriminant analysis for categorical data, including local and common-components variants.

## Installation

CRAN:

```r
install.packages("lcda")
```

Development version:

```r
remotes::install_github("mchlbckr/lcda")
```

## Usage

```r
library(lcda)

# See ?lcda, ?cclcda, and ?cclcda2 for examples
```

## Overview

Key functions:

- `lcda()`: fits separate latent class models per class.
- `cclcda()`: fits a common-components latent class model with class-specific mixing proportions.
- `cclcda2()`: fits a common-components model with class-conditional mixing proportions.

Data requirements:

- Manifest variables must be integer-coded and start at 1.
- Grouping labels must be integer-coded and start at 1.

## Documentation

The package includes a vignette with a worked example:

```r
vignette("lcda")
```

## Reference

Bücker, M., Szepannek, G., Weihs, C. (2010). Local Classification of Discrete Variables by Latent Class Models. In: Locarek-Junge, H., Weihs, C. (eds) Classification as a Tool for Research. Studies in Classification, Data Analysis, and Knowledge Organization. Springer, Berlin, Heidelberg. https://doi.org/10.1007/978-3-642-10745-0_13

Bücker, M. (2008). Lokale Diskrimination diskreter Daten. Diplomarbeit,
Fakultaet Statistik, TU Dortmund.
