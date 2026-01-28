\name{lcda}
\alias{lcda}
\alias{lcda.default}
\alias{lcda.formula}
\encoding{UTF-8}
\title{Latent Class Discriminant Analysis (LCDA)}
\description{Local Discrimination via Latent Class Models}
\usage{
lcda(x, ...)


\method{lcda}{default}(x, grouping=NULL, prior=NULL,
                       probs.start=NULL, nrep=1, m=3, 
                       maxiter = 1000, tol = 1e-10,
                       subset, na.rm = FALSE, ...)

\method{lcda}{formula}(formula, data, ...)
}
\arguments{
\item{x}{Matrix or data frame containing the explanatory variables. Manifest variables must contain only integer values, and must be coded with consecutive values from 1 to the maximum number of outcomes for each variable. All missing values should be entered as NA.}
\item{grouping}{A factor specifying the class for each observation; if not specified, the first column of \code{data} is taken. The class must be coded by integer values with consecutive values from 1 to the maximum number of classes.}
\item{formula}{Formula of the form \code{'groups ~ x1 + x2 + ...'}.}
\item{data}{Data frame from which variables specified in formula are to be taken.}
\item{prior}{The prior probabilities of class membership. If unspecified, the class proportions for the training set are used. If present, the probabilities should be specified in the order of the factor levels.}
\item{probs.start}{A list (per class) of lists of matrices (per variable) of response probabilities \eqn{\theta_{mkdr}}{\theta_{mkdr}} to be used as the starting values for the estimation algorithm. Each matrix in the list corresponds to one manifest variable, with one row for each latent class, and one column for each outcome. The default is \code{NULL}, producing random starting values. Note that if \code{nrep>1}, then any user-specified \code{probs.start} values are only used in the first of the nrep attempts.}
\item{nrep}{Number of times to estimate the model, using different random values of \code{probs.start}. The default is one. Setting \code{nrep>1} automates the search for the global -- rather than just a local -- maximum of the log-likelihood function. \code{lcda} uses the parameter estimates corresponding to the model with the greatest log-likelihood.}
\item{m}{The number of subclasses per class. Can be either a vector containing the number of subclasses per class or a number of subclasses for all classes. Default is \code{m=3}.}
\item{maxiter}{The maximum number of iterations through which the estimation algorithm will cycle.}
\item{tol}{A tolerance value for judging when convergence has been reached. When the one-iteration change in the estimated log-likelihood is less than \code{tol}, the estimation algorithm stops updating and considers the maximum log-likelihood to have been found.}
\item{subset}{An index vector specifying the cases to be used in the training sample.}
\item{na.rm}{Logical, for how \code{lcda} handles cases with missing values on the manifest variables. If \code{TRUE}, those cases are removed (listwise deleted) before estimating the model. If \code{FALSE}, cases with missing values are retained. Cases with missing covariates are always removed. The default is \code{TRUE}.}
\item{\dots}{Further arguments to be passed to \code{lcda}.}
}
\details{The \code{lcda}-function performs a Latent Class Discriminant Analysis (LCDA).  A Latent Class Modell will be estimated for each class by the \code{poLCA}-function (see \code{\link[poLCA]{poLCA}}).
The class conditional model is given by
\deqn{f_k(x) = \sum_{m=1}^{M_k} w_{mk} \prod_{d=1}^D\prod_{r=1}^{R_d} \theta_{mkdr}^{x_{kdr}},}{f_k(x) = Sum_{m=1,..,M_k} w_{mk} Prod_{d=1,...,D} Prod_{r=1,...,R_d} theta_{mkdr}^{x_{kdr}},}
where \eqn{k}{k} is the class index, \eqn{m}{m} is the latent subclass index, \eqn{d}{d} is the variable index and \eqn{r}{r} is the observation index. The variable \eqn{x_{kdr}}{x_{kdr}} is \eqn{1}{1} if the variable \eqn{d}{d} of this observation is \eqn{r}{r} and in class \eqn{k}{k}. The parameter \eqn{w_{mk}}{w_{mk}} is the class conditional mixture weight and \eqn{\theta_{mkdr}}{\theta_{mkdr}} is the probability for outcome \eqn{r}{r} of variable \eqn{d}{d} in subclass \eqn{m}{m} of class \eqn{k}{k}.

These Latent Class Models use the assumption of local independence to estimate a mixture model of latent multi-way tables. The mixture models are estimated by the EM-algorithm. The number of mixture components (\code{m}) is specified by the user. Estimated parameters include the latent-class conditional response probabilities for each manifest variable  \eqn{\theta_{mkdr}}{\theta_{mkdr}} and the class conditional mixing proportions \eqn{w_{mk}}{w_{mk}} denoting the population share of observations corresponding to each latent multi-way table.

Posterior class probabilities and class memberships can be estimated with the \code{predict} method.}
\value{
A list of class \code{lcda} containing the following components:
\item{call}{The (matched) function call.}
\item{lca.theta}{The estimated class conditional response probabilities of the LCA given as a list of matrices like \code{probs.start}.}
\item{lca.w}{The estimated mixing proportions of the LCA.}
\item{prior}{Prior probabilites.}
\item{m}{Number of latent subclasses per class.}
\item{r}{Number of possible responses per variable.}
\item{k}{Number of classes.}
\item{d}{Number of variables.}
\item{aic}{Value of the AIC for each class conditional Latent Class Model.}
\item{bic}{Value of the BIC for each class conditional Latent Class Model.}
\item{Gsq}{The likelihood ratio/deviance statistic for each class conditional model.}
\item{Chisq}{The Pearson Chi-square goodness of fit statistic for fitted vs. observed multiway tables for each class conditional model.}
}
\note{If the number of latent classes per class is unknown a model selection must be accomplished to determine the value of \code{m}. For this goal there are some model selection criteria implemented. The AIC, BIC, likelihood ratio statistic and the Chi-square goodness of fit statistic are taken from the poLCA-function (see \code{\link[poLCA]{poLCA}}). For each class these criteria can be regarded separately and for each class the number of latent classes can be determined.}
\author{ Michael B\"ucker}
\seealso{ \code{\link{predict.lcda}}, \code{\link{cclcda}}, \code{\link{predict.cclcda}}, \code{\link{cclcda2}}, \code{\link{predict.cclcda2}}, \code{\link[poLCA]{poLCA}} }
\examples{
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
}
\keyword{multivariate}
\keyword{classif}
