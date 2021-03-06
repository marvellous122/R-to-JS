% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pfilter.R, R/objfun.R
\docType{methods}
\name{pfilter}
\alias{pfilter}
\alias{pfilter,ANY-method}
\alias{pfilter,missing-method}
\alias{pfilterd_pomp-class}
\alias{pfilterd_pomp}
\alias{pfilter-data.frame}
\alias{pfilter,data.frame-method}
\alias{pfilter-pomp}
\alias{pfilter,pomp-method}
\alias{pfilter-pfilterd_pomp}
\alias{pfilter,pfilterd_pomp-method}
\alias{pfilter-objfun}
\alias{pfilter,objfun-method}
\title{Particle filter}
\usage{
\S4method{pfilter}{data.frame}(data, Np, tol = 1e-17, max.fail = Inf,
  params, rinit, rprocess, dmeasure, pred.mean = FALSE,
  pred.var = FALSE, filter.mean = FALSE, filter.traj = FALSE,
  save.states = FALSE, ..., verbose = getOption("verbose", FALSE))

\S4method{pfilter}{pomp}(data, Np, tol = 1e-17, max.fail = Inf,
  pred.mean = FALSE, pred.var = FALSE, filter.mean = FALSE,
  filter.traj = FALSE, save.states = FALSE, ...,
  verbose = getOption("verbose", FALSE))

\S4method{pfilter}{pfilterd_pomp}(data, Np, tol, ...,
  verbose = getOption("verbose", FALSE))

\S4method{pfilter}{objfun}(data, ...)
}
\arguments{
\item{data}{either a data frame holding the time series data,
or an object of class \sQuote{pomp},
i.e., the output of another \pkg{pomp} calculation.}

\item{Np}{the number of particles to use.
This may be specified as a single positive integer, in which case the same number of particles will be used at each timestep.
Alternatively, if one wishes the number of particles to vary across timesteps, one may specify \code{Np} either as a vector of positive integers of length \preformatted{length(time(object,t0=TRUE))} or as a function taking a positive integer argument.
In the latter case, \code{Np(k)} must be a single positive integer, representing the number of particles to be used at the \code{k}-th timestep:
\code{Np(0)} is the number of particles to use going from \code{timezero(object)} to \code{time(object)[1]},
\code{Np(1)}, from \code{timezero(object)} to \code{time(object)[1]},
and so on,
while when \code{T=length(time(object,t0=TRUE))}, \code{Np(T)} is the number of particles to sample at the end of the time-series.}

\item{tol}{positive numeric scalar;
particles with likelihood less than \code{tol} are considered to be incompatible with the data.
See the section on \emph{Filtering Failures} for more information.}

\item{max.fail}{integer; the maximum number of filtering failures allowed (see below).
If the number of filtering failures exceeds this number, execution will terminate with an error.
By default, \code{max.fail} is set to infinity, so no error can be triggered.}

\item{params}{optional; named numeric vector of parameters.
This will be coerced internally to storage mode \code{double}.}

\item{rinit}{simulator of the initial-state distribution.
This can be furnished either as a C snippet, an \R function, or the name of a pre-compiled native routine available in a dynamically loaded library.
Setting \code{rinit=NULL} sets the initial-state simulator to its default.
For more information, see \link[=rinit_spec]{here}.}

\item{rprocess}{simulator of the latent state process, specified using one of the \link[=rprocess_spec]{rprocess plugins}.
Setting \code{rprocess=NULL} removes the latent-state simulator.
For more information, \link[=rprocess_spec]{see the documentation on these plugins}.}

\item{dmeasure}{evaluator of the measurement model density, specified either as a C snippet, an \R function, or the name of a pre-compiled native routine available in a dynamically loaded library.
Setting \code{dmeasure=NULL} removes the measurement density evaluator.
For more information, see \link[=dmeasure_spec]{here}.}

\item{pred.mean}{logical; if \code{TRUE}, the prediction means are calculated for the state variables and parameters.}

\item{pred.var}{logical; if \code{TRUE}, the prediction variances are calculated for the state variables and parameters.}

\item{filter.mean}{logical; if \code{TRUE}, the filtering means are calculated for the state variables and parameters.}

\item{filter.traj}{logical; if \code{TRUE}, a filtered trajectory is returned for the state variables and parameters.}

\item{save.states}{logical.
If \code{save.states=TRUE}, the state-vector for each particle at each time is saved.}

\item{...}{additional arguments supply new or modify existing model characteristics or components.
See \code{\link{pomp}} for a full list of recognized arguments.

When named arguments not recognized by \code{\link{pomp}} are provided, these are made available to all basic components via the so-called \dfn{userdata} facility.
This allows the user to pass information to the basic components outside of the usual routes of covariates (\code{covar}) and model parameters (\code{params}).
See the \link[=userdata]{userdata documentation here} for information on how to use this facility.}

\item{verbose}{logical; if \code{TRUE}, diagnostic messages will be printed to the console.}
}
\value{
An object of class \sQuote{pfilterd_pomp}, which extends class \sQuote{pomp}.
}
\description{
A plain vanilla sequential Monte Carlo (particle filter) algorithm.
Resampling is performed at each observation.
}
\section{Methods}{

\describe{
\item{logLik}{ the estimated log likelihood  }
\item{cond.logLik}{ the estimated conditional log likelihood }
\item{eff.sample.size}{
the (time-dependent) estimated effective sample size }
\item{pred.mean, pred.var}{ the mean and variance of the approximate prediction distribution }
\item{filter.mean}{ the mean of the filtering distribution }
\item{filter.traj}{ retrieve one sample from the smoothing distribution}
\item{as.data.frame}{ coerce to a data frame }
\item{plot}{diagnostic plots}
}
}

\section{Filtering failures}{

If the degree of disagreement between model and data becomes sufficiently large, a \dQuote{filtering failure} results.
A filtering failure occurs when, at some time point, none of the \code{Np} particles is compatible with the data.
In particular, if the conditional likelihood of a particle at any time is below the tolerance value \code{tol}, then that particle is considered to be uninformative and its likelihood is taken to be zero.
A filtering failure occurs when this is the case for all particles.
A warning is generated when this occurs unless the cumulative number of failures exceeds \code{max.fail}, in which case an error is generated.
}

\examples{
pf <- pfilter(gompertz(),Np=1000)	## use 1000 particles

plot(pf)
logLik(pf)
cond.logLik(pf)			## conditional log-likelihoods
eff.sample.size(pf)             ## effective sample size
logLik(pfilter(pf))      	## run it again with 1000 particles

## run it again with 2000 particles
pf <- pfilter(pf,Np=2000,filter.mean=TRUE,filter.traj=TRUE)
fm <- filter.mean(pf)    	## extract the filtering means
ft <- filter.traj(pf)    	## one draw from the smoothing distribution
}
\references{
M. S. Arulampalam, S. Maskell, N. Gordon, & T. Clapp.
A Tutorial on Particle Filters for Online Nonlinear, Non-Gaussian Bayesian Tracking.
IEEE Trans. Sig. Proc. 50:174--188, 2002.
}
\seealso{
Other elementary POMP methods: \code{\link{pomp2-package}},
  \code{\link{probe}}, \code{\link{simulate}},
  \code{\link{spect}}

Other particle filter methods: \code{\link{bsmc2}},
  \code{\link{cond.logLik}}, \code{\link{eff.sample.size}},
  \code{\link{filter.mean}}, \code{\link{filter.traj}},
  \code{\link{mif2}}, \code{\link{pmcmc}},
  \code{\link{pred.mean}}, \code{\link{pred.var}}
}
\author{
Aaron A. King
}
\concept{elementary POMP methods}
\concept{particle filter methods}
