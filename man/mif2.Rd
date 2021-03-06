% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mif2.R
\docType{methods}
\name{mif2}
\alias{mif2}
\alias{mif2,missing-method}
\alias{mif2,ANY-method}
\alias{mif2-data.frame}
\alias{mif2,data.frame-method}
\alias{mif2-pomp}
\alias{mif2,pomp-method}
\alias{mif2-pfilterd_pomp}
\alias{mif2,pfilterd_pomp-method}
\alias{mif2-mif2d_pomp}
\alias{mif2,mif2d_pomp-method}
\title{Iterated filtering: maximum likelihood by iterated, perturbed Bayes maps}
\usage{
\S4method{mif2}{data.frame}(data, Nmif = 1, rw.sd,
  cooling.type = c("geometric", "hyperbolic"), cooling.fraction.50, Np,
  tol = 1e-17, max.fail = Inf, params, rinit, rprocess, dmeasure,
  partrans, ..., verbose = getOption("verbose", FALSE))

\S4method{mif2}{pomp}(data, Nmif = 1, rw.sd,
  cooling.type = c("geometric", "hyperbolic"), cooling.fraction.50, Np,
  tol = 1e-17, max.fail = Inf, ..., verbose = getOption("verbose",
  FALSE))

\S4method{mif2}{pfilterd_pomp}(data, Nmif = 1, Np, tol, max.fail = Inf,
  ..., verbose = getOption("verbose", FALSE))

\S4method{mif2}{mif2d_pomp}(data, Nmif, rw.sd, cooling.type,
  cooling.fraction.50, ..., verbose = getOption("verbose", FALSE))
}
\arguments{
\item{data}{either a data frame holding the time series data,
or an object of class \sQuote{pomp},
i.e., the output of another \pkg{pomp} calculation.}

\item{Nmif}{The number of filtering iterations to perform.}

\item{rw.sd}{specification of the magnitude of the random-walk perturbations that will be applied to some or all model parameters.
Parameters that are to be estimated should have positive perturbations specified here.
The specification is given using the \code{\link{rw.sd}} function, which creates a list of unevaluated expressions.
The latter are evaluated in a context where the model time variable is defined (as \code{time}).
The expression \code{ivp(s)} can be used in this context as shorthand for \preformatted{ifelse(time==time[1],s,0).}
Likewise, \code{ivp(s,lag)} is equivalent to \preformatted{ifelse(time==time[lag],s,0).}
See below for some examples.

The perturbations that are applied are normally distributed with the specified s.d.
If \code{transform = TRUE}, then they are applied on the estimation scale.}

\item{cooling.type, cooling.fraction.50}{specifications for the cooling schedule,
i.e., the manner and rate with which the intensity of the parameter perturbations is reduced with successive filtering iterations.
\code{cooling.type} specifies the nature of the cooling schedule.
See below (under \dQuote{Specifying the perturbations}) for more detail.}

\item{Np}{the number of particles to use in filtering.
This may be specified as a single positive integer, in which case the same number of particles will be used at each timestep.
Alternatively, if one wishes the number of particles to vary across timestep, one may specify \code{Np} either as a vector of positive integers (of length \code{length(time(object))}) or as a function taking a positive integer argument.
In the latter case, \code{Np(n)} must be a single positive integer,
representing the number of particles to be used at the \code{n}-th timestep:
\code{Np(1)} is the number of particles to use going from \code{timezero(object)} to \code{time(object)[1]},
\code{Np(2)}, from \code{time(object)[1]} to \code{time(object)[2]},
and so on.}

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

\item{partrans}{optional parameter transformations, constructed using \code{\link{parameter_trans}}.

Many algorithms for parameter estimation search an unconstrained space of parameters.
When working with such an algorithm and a model for which the parameters are constrained, it can be useful to transform parameters.
One should supply the \code{partrans} argument via a call to \code{\link{parameter_trans}}.
For more information, see \link[=parameter_trans]{here}.
Setting \code{partrans=NULL} removes the parameter transformations, i.e., sets them to the identity transformation.}

\item{...}{additional arguments supply new or modify existing model characteristics or components.
See \code{\link{pomp}} for a full list of recognized arguments.

When named arguments not recognized by \code{\link{pomp}} are provided, these are made available to all basic components via the so-called \dfn{userdata} facility.
This allows the user to pass information to the basic components outside of the usual routes of covariates (\code{covar}) and model parameters (\code{params}).
See the \link[=userdata]{userdata documentation here} for information on how to use this facility.}

\item{verbose}{logical; if \code{TRUE}, diagnostic messages will be printed to the console.}
}
\value{
Upon successful completion, \code{mif2} returns an object of class
\sQuote{mif2d_pomp}.
}
\description{
An iterated filtering algorithm for estimating the parameters of a partially-observed Markov process.
Running \code{mif2} causes the algorithm to perform a specified number of particle-filter iterations.
At each iteration, the particle filter is performed on a perturbed version of the model, in which the parameters to be estimated are subjected to random perturbations at each observation.
This extra variability effectively smooths the likelihood surface and combats particle depletion by introducing diversity into particle population.
As the iterations progress, the magnitude of the perturbations is diminished according to a user-specified cooling schedule.
The algorithm is presented and justified in Ionides et al. (2015).
}
\section{Methods}{

The following methods are available for such an object:
\describe{
\item{\code{\link{continue}}}{ picks up where \code{mif2} leaves off and performs more filtering iterations. }
\item{\code{\link{logLik}}}{ returns the so-called \dfn{mif log likelihood} which is the log likelihood of the perturbed model, not of the focal model itself.
To obtain the latter, it is advisable to run several \code{\link{pfilter}} operations on the result of a \code{mif2} computatation.}
\item{\code{\link{coef}}}{ extracts the point estimate }
\item{\code{\link{eff.sample.size}}}{ extracts the effective sample size of the final filtering iteration}
}
Various other methods can be applied, including all the methods applicable to a \code{\link[=pfilter]{pfilterd_pomp}} object and all other \pkg{pomp} estimation algorithms and diagnostic methods.
}

\section{Specifying the perturbations}{

The \code{rw.sd} function simply returns a list containing its arguments as unevaluated expressions.
These are then evaluated in a context containing the model \code{time} variable.  This allows for easy specification of the structure of the perturbations that are to be applied.
For example,
\preformatted{
    rw.sd(a=0.05, b=ifelse(0.2,time==time[1],0),
          c=ivp(0.2), d=ifelse(time==time[13],0.2,0),
          e=ivp(0.2,lag=13), f=ifelse(time<23,0.02,0))
}
results in perturbations of parameter \code{a} with s.d. 0.05 at every time step, while parameters \code{b} and \code{c} both get perturbations of s.d. 0.2 only before the first observation.
Parameters \code{d} and \code{e}, by contrast, get perturbations of s.d.  0.2 only before the thirteenth observation.
Finally, parameter \code{f} gets a random perturbation of size 0.02 before every observation falling before \eqn{t=23}.

On the \eqn{m}-th IF2 iteration, prior to time-point \eqn{n}, the \eqn{d}-th parameter is given a random increment normally distributed with mean \eqn{0} and standard deviation \eqn{c_{m,n} \sigma_{d,n}}{c[m,n] sigma[d,n]}, where \eqn{c} is the cooling schedule and \eqn{\sigma}{sigma} is specified using \code{rw.sd}, as described above.
Let \eqn{N} be the length of the time series and \eqn{\alpha=}{alpha=}\code{cooling.fraction.50}.
Then, when \code{cooling.type="geometric"}, we have \deqn{c_{m,n}=\alpha^{\frac{n-1+(m-1)N}{50N}}.}{c[m,n]=alpha^((n-1+(m-1)N)/(50N)).}
When \code{cooling.type="hyperbolic"}, we have \deqn{c_{m,n}=\frac{s+1}{s+n+(m-1)N},}{c[m,n]=(s+1)/(s+n+(m-1)N),} where \eqn{s} satisfies \deqn{\frac{s+1}{s+50N}=\alpha.}{(s+1)/(s+50N)=alpha.}
Thus, in either case, the perturbations at the end of 50 IF2 iterations are a fraction \eqn{\alpha}{alpha} smaller than they are at first.
}

\section{Filtering failures}{

If the degree of disagreement between model and data becomes sufficiently large, a \dQuote{filtering failure} results.
A filtering failure occurs when, at some time point, none of the \code{Np} particles is compatible with the data.
In particular, if the conditional likelihood of a particle at any time is below the tolerance value \code{tol}, then that particle is considered to be uninformative and its likelihood is taken to be zero.
A filtering failure occurs when this is the case for all particles.
A warning is generated when this occurs unless the cumulative number of failures exceeds \code{max.fail}, in which case an error is generated.
}

\references{
E. L. Ionides, D. Nguyen, Y. Atchad\'e, S. Stoev, and A. A. King.
Inference for dynamic and latent variable models via iterated, perturbed Bayes maps.
Proc. Natl. Acad. Sci. U.S.A., 112:719--724, 2015.
}
\seealso{
Other particle filter methods: \code{\link{bsmc2}},
  \code{\link{cond.logLik}}, \code{\link{eff.sample.size}},
  \code{\link{filter.mean}}, \code{\link{filter.traj}},
  \code{\link{pfilter}}, \code{\link{pmcmc}},
  \code{\link{pred.mean}}, \code{\link{pred.var}}

Other \pkg{pomp} parameter estimation methods: \code{\link{abc}},
  \code{\link{bsmc2}}, \code{\link{kalman}},
  \code{\link{nlf}}, \code{\link{pmcmc}},
  \code{\link{pomp2-package}}, \code{\link{probe.match}},
  \code{\link{spect.match}}
}
\author{
Aaron A. King, Edward L. Ionides, Dao Nguyen
}
\concept{\pkg{pomp} parameter estimation methods}
\concept{particle filter methods}
