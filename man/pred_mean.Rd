% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pred_mean.R
\docType{methods}
\name{pred.mean}
\alias{pred.mean}
\alias{pred.mean,ANY-method}
\alias{pred.mean,missing-method}
\alias{pred.mean-kalmand_pomp}
\alias{pred.mean,kalmand_pomp-method}
\alias{pred.mean-pfilterd_pomp}
\alias{pred.mean,pfilterd_pomp-method}
\title{Prediction mean}
\usage{
\S4method{pred.mean}{kalmand_pomp}(object, vars, ...)

\S4method{pred.mean}{pfilterd_pomp}(object, vars, ...)
}
\arguments{
\item{object}{result of a filtering computation}

\item{vars}{optional character; names of variables}

\item{...}{ignored}
}
\description{
The mean of the prediction distribution
}
\details{
The prediction distribution is that of
\deqn{X_t \vert Y_1=y^*_1,\dots,Y_{t-1}=y^*_{t-1},}{Xt | Y1=y1*,\dots,Y(t-1)=y(t-1)*,}
where \eqn{X_t}{Xt}, \eqn{Y_t}{Yt} are the latent state and observable processes, respectively, and \eqn{y^*_t}{yt*} is the data, at time \eqn{t}.

The prediction mean is therefore the expectation of this distribution
\deqn{E[X_t \vert Y_1=y^*_1,\dots,Y_{t-1}=y^*_{t-1}].}{E[Xt | Y1=y1*,\dots,Y(t-1)=y(t-1)*].}
}
\seealso{
Other particle filter methods: \code{\link{bsmc2}},
  \code{\link{cond.logLik}}, \code{\link{eff.sample.size}},
  \code{\link{filter.mean}}, \code{\link{filter.traj}},
  \code{\link{mif2}}, \code{\link{pfilter}},
  \code{\link{pmcmc}}, \code{\link{pred.var}}
}
\concept{particle filter methods}
