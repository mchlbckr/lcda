\name{cclcda2}
\alias{cclcda2}
\alias{cclcda2.default}
\alias{cclcda2.formula}
\encoding{UTF-8}
\title{Common Components Latent Class Discriminant Analysis 2 (CCLCDA2)}
\description{Local Discrimination via Latent Class Models with common components}
\usage{
cclcda2(x, ...)

\method{cclcda2}{default}(x, grouping=NULL, prior=NULL,
                          probs.start=NULL, wmk.start=NULL, 
                          nrep=1, m=3, maxiter = 1000, 
                          tol = 1e-10, subset, na.rm = FALSE, ...)

\method{cclcda2}{formula}(formula, data, ...)
}
\arguments{
\item{x}{Matrix or data frame containing the explanatory variables. Manifest variables must contain only integer values, and must be coded with consecutive values from 1 to the maximum number of outcomes for each variable. All missing values should be entered as NA.}
\item{grouping}{A factor specifying the class for each observation; if not specified, the first column of 'data' is taken. The class must be coded by integer values with consecutive values from 1 to the maximum number of classes.}
\item{formula}{Formula of the form \code{'groups ~ x1 + x2 + ...'}.}
\item{data}{Data frame from which variables specified in formula are to be taken.}
\item{prior}{The prior probabilities of class membership. If unspecified, the class proportions for the training set are used. If present, the probabilities should be specified in the order of the factor levels.}
\item{probs.start}{A list of matrices (per variable) of response probabilities \eqn{\theta_{mkdr}}{\theta_{mkdr}} to be used as the starting values for the estimation algorithm. Each matrix in the list corresponds to one manifest variable, with one row for each latent class, and one column for each outcome. The default is \code{NULL}, producing random starting values. Note that if \code{nrep>1}, then any user-specified \code{probs.start} values are only used in the first of the nrep attempts.}
\item{wmk.start}{A matrix of starting values for the parameter \eqn{w_{mk}}{w_{mk}} (see details). The default is \code{NULL}, producing random starting values. Note that if \code{nrep>1}, then any user-specified \code{wmk.start} values are only used in the first of the nrep attempts.}
\item{nrep}{Number of times to estimate the model, using different random values of \code{probs.start}. The default is one. Setting \code{nrep>1} automates the search for the global -- rather than just a local -- maximum of the log-likelihood function. \code{cclcda2} uses the parameter estimates corresponding to the model with the greatest log-likelihood.}
\item{m}{The number of subclasses. Can be either a vector containing the number of subclasses per class or a number of subclasses for all classes. Default is \code{m=3}.}
\item{maxiter}{The maximum number of iterations through which the estimation algorithm will cycle.}
\item{tol}{A tolerance value for judging when convergence has been reached. When the one-iteration change in the estimated log-likelihood is less than \code{tol}, the estimation algorithm stops updating and considers the maximum log-likelihood to have been found.}
\item{subset}{An index vector specifying the cases to be used in the training sample.}
\item{na.rm}{Logical, for how \code{cclcda2} handles cases with missing values on the manifest variables. If \code{TRUE}, those cases are removed (listwise deleted) before estimating the model. If \code{FALSE}, cases with missing values are retained. Cases with missing covariates are always removed. The default is \code{TRUE}.}
\item{\dots}{Further arguments to be passed to \code{cclcda2.default}.}
}


\details{
The \code{cclcda2}-function performs a Common Components Latent Class Discriminant Analysis 2 (CCLCDA2). The class conditional model to estimate is
\deqn{f_k(x) = \sum_{m=1}^{M_k} w_{mk} \prod_{d=1}^D\prod_{r=1}^{R_d} \theta_{mdr}^{x_{dr}},}{f_k(x) = Sum_{m=1,..,M_k} w_{mk} Prod_{d=1,...,D} Prod_{r=1,...,R_d} theta_{mdr}^{x_{dr}},}
where \eqn{m}{m} is the latent subclass index, \eqn{d}{d} is the variable index and \eqn{r}{r} is the observation index. The variable \eqn{x_{dr}}{x_{dr}} is \eqn{1}{1} if the variable \eqn{d}{d} of this observation is \eqn{r}{r}.
This Latent Class Modell will be estimated. The class conditional mixing proportions \eqn{w_{mk}}{w_{mk}} and the parameters \eqn{\theta_{mdr}}{theta_{mdr}} are computed in every step of the EM-Algorithm.

The LCA uses the assumption of local independence to estimate a mixture model of latent multi-way tables, the number of which (\code{m}) is specified by the user. Estimated parameters include the latent-class-conditional response probabilities for each manifest variable \eqn{\theta_{mdr}}{theta_{mdr}} and the class conditional mixing proportions \eqn{w_{mk}}{w_{mk}} denoting population share of observations corresponding to each latent multi-way table per class. 

Posterior class probabilities can be estimated with the \code{predict} method.
}
\value{
A list of class \code{cclcda2} containing the following components:
\item{call}{The (matched) function call.}
\item{lca.theta}{The estimated class conditional response probabilities of the LCA given as a list of matrices like \code{probs.start}.}
\item{lca.w}{The estimated mixing proportions of the LCA.}
\item{lca.wmk}{The estimated class conditional mixing proportions of the LCA.}
\item{prior}{Prior probabilites.}
\item{m}{Number of latent subclasses.}
\item{r}{Number of different responses per variable.}
\item{k}{Number of classes.}
\item{d}{Number of variables.}
\item{aic}{Value of the AIC for each class conditional Latent Class Model.}
\item{bic}{Value of the BIC for each class conditional Latent Class Model.}
\item{Gsq}{The likelihood ratio/deviance statistic for each class conditional model.}
\item{Chisq}{The Pearson Chi-square goodness of fit statistic for fitted vs. observed multiway tables for each class conditional model.}
\item{entropy}{Value of the weighted entropy as described below.}
\item{gini}{Value of the weighted Gini coefficient as described below.}
\item{chi.stat}{Value of the Chi-square test statistik of the test  of latent class membership and class membership as described below.}
\item{chi.p}{P Value of the Chi-square of the test  of latent class membership and class membership as described below.}
}
\note{If the number of latent classes per class is unknown a model selection must be accomplished to determine the value of \code{m}. For this goal there are some model selection criteria implemented. The AIC, BIC, likelihood ratio statistic and the Chi-square goodness of fit statistic are taken from the poLCA-function (see \code{\link[poLCA]{poLCA}}).

Additionally \code{cclcda2} provides quality criteria which should give insight into the model's classification potential. These criteria are similar to the splitting criteria of classification trees. The impurity measures are

-- Weighted entropy: The weighted entropy is given by
\deqn{H := - \sum_{m=1}^M  P(m) \sum_{k=1}^K \left(P(k|m) \cdot \log_{K}{P(k|m)}\right).}{H := -Sum_{m=1,..,M} [ P(m) Sum_{k=1,..,K} [ P(k|m) * \log_K P(k|m) ] ].}

-- Weighted Gini coefficient: The weighted Gini coefficient is given by
\deqn{G := \sum_{m=1}^M  P(m) \left[ 1- \sum_{k=1}^{K} \left( P(k|m) \right)^2 \right].}{G := - Sum_{m=1...,M}  P(m) [ 1- Sum_{k=1,...,K} ( P(k|m) )^2 ].}

-- Pearson's Chi-square test: A Pearson's Chi-square test is performed to test the independence of latent class membership and class membership.
}
\author{ Michael B\"ucker}
\seealso{ \code{\link{predict.cclcda2}}, \code{\link{lcda}}, \code{\link{predict.lcda}}, \code{\link{cclcda}}, \code{\link{predict.cclcda}}, \code{\link[poLCA]{poLCA}} }
\examples{
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
object <- cclcda2(data, grouping, m=4)
object
}
\keyword{multivariate}
\keyword{classif}
