\name{mcll_se}

\alias{mcll_se}

\title{Standard error estimation using MCLL}

\description{
   Standard error estimation using Monte Carlo local likelihood 
}

\usage{
mcll_se(data, par, H.prior, alp=0.7,  
        method="Nelder-Mead",  lower = -Inf, upper = Inf, control=list() )
}

\arguments{
    \item{data}{posterior samples of model parameters.
                a \code{matrix} or \code{data.frame} of size \eqn{m \times p} (\eqn{m}: sample size, \eqn{p}: dimension of the parameters).}
    \item{par}{MCLL parameter estimates on the original scale.}
    \item{H.prior}{Hessian matrix of the prior evaluated at \code{par}.}
    \item{alp}{a real value between 0 and 1. \eqn{\alpha} takes a value between 0 and 1, which is the nearest neighbor bandwidth
               with the \eqn{k}th smallest distance \eqn{d} where \eqn{k = \lfloor n \alpha \rfloor} and \eqn{d(x, x_{i}) = | x - x_{i} |}
               with the sample size \eqn{n}.}
    \item{method}{an optimization method to be used to find the coefficients of the polynomial approximation 
                    to the log-posterior at the MCLL estimates \code{par}. 
                    Options from \code{optim} are Nelder-Mead, BFGS, CG, L-BFGS-B, and SANN.}
    \item{lower, upper}{bounds on the variables for the L-BFGS-B method in \code{optim}.}
    \item{control}{a list of control parameters. See control options for \code{optim}.}

}

\details{
   Standard error estimation in the Monte Carlo local likelihood method.
   For details, see Section 3 in Jeon et al. (2012).
   The posterior samples and paramter values should be on the real line (e.g., variance parameters should be in the log-scale).

}

\value{
  \code{mcll_se} returns a vector containing standard error estimates for the MCLL parameter estimates \code{par}.      
}



\references{

  Jeon, M., Kaufman, C., and Rabe-Hesketh, S. (2012). Monte Carlo local likelihood 
  for estimating generalized linear mixed models. Submitted for publication. 

}

\author{
  Minjeong Jeon <mjj@berkeley.edu>
}


\seealso{
 \code{\link{mcll_est}} 
}

\examples{
## example 

# data preparation
data(samp) 

# prior function
prior.func <- function(vec.t) {
    sum(dnorm(vec.t, m= c(0,0,0,0, -0.9870405, -0.9870405) ,
                sd=c(100,100,100,100, 1/0.766672, 1/0.766672) , log=TRUE))
}

## parameter estimation
run1 <- system.time(
    result1 <- mcll_est(data=samp, prior.func= prior.func, alp=0.7, 
        method = "BFGS", control= list(maxit=10000) )
)

par <- result1$par # original scale 

## standard error estimation 

# H.prior: analytical solution 
p.var = c(100,100,100,100, 1/0.766672, 1/0.766672)^2
H.prior <- -diag(1/p.var)

# H.prior: numerical solution 
# library(numDeriv)
# H.prior <- hessian(prior.func, par)

# SE estimation (NOT RUN)
#run2 <- system.time(
#    se <- mcll_se(data=samp, par=par, H.prior = H.prior,  alp=0.7, 
#        method= "Nelder-Mead" , control=list(maxit=20000)) 
#)

#se
#       b0        b1        b2        b3      tau0      tau1 
#0.4057844 0.5640063 0.4907643 0.6663096 0.3022842 0.2999727 
 
 
}


\keyword{mcll }
\keyword{se} 
