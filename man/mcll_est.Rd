\name{mcll_est}

\alias{mcll_est}

\title{Parameter estimation using MCLL}

\description{
   Parameter estimation using Monte Carlo local likelihood
}

\usage{
mcll_est(data, prior.func, alp=0.7,
        method="BFGS",  lower = -Inf, upper = Inf,
        control=list(), use.locfit=TRUE,
        con.manual=list(method="BFGS", lower = -Inf, upper = Inf,
        control=list()) )
}


\arguments{
    \item{data}{posterior samples of model parameters.
                a \code{matrix} or \code{data.frame} of size \eqn{m \times p} (\eqn{m}: sample size, \eqn{p}: dimension of the parameters).}
    \item{prior.func}{a prior function. An argument should be a vector of parameter values and
                      a return value should be the log prior density for those parameter values.}
    \item{alp}{a real value between 0 and 1. \eqn{\alpha} takes a value between 0 and 1, which is the nearest neighbor bandwidth
               with the \eqn{k}th smallest distance \eqn{d} where \eqn{k = \lfloor n \alpha \rfloor} and \eqn{d(x, x_{i}) = | x - x_{i} | }
               with the sample size \eqn{n}}
    \item{method}{an optimization method to be used in maximizing the approximation to the unnormalized log-likelihood.
                    Options from \code{optim} are Nelder-Mead, BFGS, CG, L-BFGS-B, and SANN.}
    \item{lower, upper}{bounds on the variables for the L-BFGS-B method in \code{optim}.}
    \item{control}{a list of control parameters. See control options for \code{optim}.}
    \item{use.locfit}{logical. If TRUE, \code{locfit} is used to compute a local likelihood density estimate. If FALSE, a code from the \code{mcll} package is used. \code{locfit} is typically faster but sometimes fails for high-dimensional parameter spaces.}
    \item{con.manual}{a list. An optimization method for finding the polynomial coefficients, lower and upper bounds on the variables for the L-BFGS-B method, and a list of control parameters when \code{use.locfit} = FALSE. See control options for \code{optim}.}
}

\details{
   Nested maximizations in Step 2 in the Monte Carlo local likelihood estimation.
   It makes use of the R package \code{locfit} and the R function \code{optim}.
   The posterior samples should be on the real line (e.g., variance parameters should be on the log-scale).
   The prior distributions (provided as a form of \code{prior.func}) should be the same as those used for obtaining the posterior
   samples of the model parameters.
   For details, see Section 2 in Jeon et al. (2012).

}

\value{
   \code{mcll_est} returns a list of the following components,

    \item{par}{parameter estimates on the original scale.}
    \item{value}{value of the function corresponding to \code{par}. This is an unnormalized log-likelihood from the MCLL algorithm.
            One can use this to compute the Bayes factor. For details, see Appendix of Jeon et al. (2012).}
    \item{counts}{a two-element integer vector giving the number of calls to function and gradient, respectively.}
    \item{convergence}{an integer code. 0 indicates successful completion.
     For possible error codes, see the document for \code{optim}.}
    \item{message}{a character string giving any additional information returned by \code{optim}, or NULL.}

}
\references{

  Jeon, M., Kaufman, C., and Rabe-Hesketh, S. (2014). Monte Carlo local likelihood 
  for approximate MLE of complex models. Under revision.

  Loader, C. (2012). locfit: Local regression, likelihood, and density estimation. Downloadable from
 \code{http://cran.r-project.org/web/packages/locfit/index.html}.



}

\author{
  Minjeong Jeon <jeon.117@osu.edu>
}


\seealso{
 \code{\link{mcll_se}}
}

\examples{
## example

# posterior samples
data(samp)

# prior function
prior.func <- function(vec.t) {
    sum(dnorm(vec.t, m= c(0,0,0,0, -0.9870405, -0.9870405) ,
                sd=c(100,100,100,100, 1/0.766672, 1/0.766672) , log=TRUE))
}

## parameter estimation
run1 <- system.time(
    result1 <- mcll_est(data=samp, prior.func= prior.func, alp=0.7,
        method = "BFGS", control= list(maxit=10000))
)

# result1$par
#            b0        b1         b2       b3       tau0     tau1
#[1,] 0.9275766 -2.871686 -0.6488625 3.589313 0.08118962 0.148478

}


\keyword{mcll }
\keyword{locfit}
\keyword{est}
