% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mfpca.sc.R
\name{mfpca.sc}
\alias{mfpca.sc}
\title{Multilevel functional principal components analysis by smoothed covariance}
\usage{
mfpca.sc(Y = NULL, id = NULL, visit = NULL, twoway = FALSE,
  argvals = NULL, nbasis = 10, pve = 0.99, npc = NULL, makePD = FALSE,
  center = TRUE, cov.est.method = 2, integration = "trapezoidal")
}
\arguments{
\item{Y, }{The user must supply a matrix of functions on a regular grid}

\item{id}{Must be supplied, a vector containing the id information used to identify clusters}

\item{visit}{A vector containing information used to identify visits. Defaults to \code{NULL}.}

\item{twoway}{logical, indicating whether to carry out twoway ANOVA and calculate visit-specific means. Defaults to \code{FALSE}.}

\item{argvals}{function argument.}

\item{nbasis}{number of B-spline basis functions used for estimation of the
mean function and bivariate smoothing of the covariance surface.}

\item{pve}{proportion of variance explained: used to choose the number of
principal components.}

\item{npc}{prespecified value for the number of principal components (if
given, this overrides \code{pve}).}

\item{makePD}{logical: should positive definiteness be enforced for the
covariance surface estimate? Defaults to \code{FALSE} Only \code{FALSE} is currently supported.}

\item{center}{logical: should an estimated mean function be subtracted from
\code{Y}? Set to \code{FALSE} if you have already demeaned the data using
your favorite mean function estimate.}

\item{cov.est.method}{covariance estimation method. If set to \code{1}, a
one-step method that applies a bivariate smooth to the \eqn{y(s_1)y(s_2)}
values. This can be very slow. If set to \code{2} (the default), a two-step
method that obtains a naive covariance estimate which is then smoothed. \code{2} is currently supported.}

\item{integration}{quadrature method for numerical integration; only
\code{"trapezoidal"} is currently supported.}
}
\value{
An object of class \code{mfpca} containing:
\item{Yhat}{FPC approximation (projection onto leading components)
of \code{Y}, estimated curves for all subjects and visits}
\item{Yhat.subject}{estimated subject specific curves for all subjects} 
\item{Y}{the observed data}\item{scores}{\eqn{n
\times npc} matrix of estimated FPC scores for level1 and level2.} \item{mu}{estimated mean
function (or a vector of zeroes if \code{center==FALSE}).} \item{efunctions
}{\eqn{d \times npc} matrix of estimated eigenfunctions of the functional
covariance, i.e., the FPC basis functions for levels 1 and 2.} \item{evalues}{estimated
eigenvalues of the covariance operator, i.e., variances of FPC scores for levels 1 and 2.}
\item{npc }{number of FPCs: either the supplied \code{npc}, or the minimum
number of basis functions needed to explain proportion \code{pve} of the
variance in the observed curves for levels 1 and 2.} \item{sigma2}{estimated measurement error
variance.} \item{eta}{the estimated visit specific shifts from overall mean.}
}
\description{
Decomposes functional observations using functional principal components
analysis. A mixed model framework is used to estimate scores and obtain
variance estimates.
}
\details{
This function computes a multilevel FPC decomposition for a set of observed curves,
which may be sparsely observed and/or measured with error. A mixed model
framework is used to estimate level 1 and level 2  scores.

MFPCA was proposed in Di et al. (2009), with variations for 
MFPCA with sparse data in Di et al. (2014). 
\code{mfpca.sc} uses penalized splines to smooth the covariance functions, as
Described in Di et al. (2009) and Goldsmith et al. (2013).
}
\examples{
 \dontrun{
 data(DTI)
 DTI = subset(DTI, Nscans < 6)  ## example where all subjects have 6 or fewer visits
 id  = DTI$ID
 Y = DTI$cca
 mfpca.DTI =  mfpca.sc(Y=Y, id = id, twoway = TRUE)
 }
}
\references{
Di, C., Crainiceanu, C., Caffo, B., and Punjabi, N. (2009).
Multilevel functional principal component analysis. \emph{Annals of Applied
Statistics}, 3, 458--488.

Di, C., Crainiceanu, C., Caffo, B., and Punjabi, N. (2014).
Multilevel sparse functional principal component analysis. \emph{Stat}, 3, 126--143.

Goldsmith, J., Greven, S., and Crainiceanu, C. (2013). Corrected confidence
bands for functional data using principal components. \emph{Biometrics},
69(1), 41--51.
}
\author{
Julia Wrobel \email{jw3134@cumc.columbia.edu}, Jeff Goldsmith \email{jeff.goldsmith@columbia.edu}, and Chongzhi Di
}
