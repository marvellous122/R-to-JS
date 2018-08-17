##' Two-dimensional random-walk process
##'
##' \code{rw2} is a \sQuote{pomp} object encoding a 2-D normal random walk.
##'
##' The random-walk process is fully but noisily observed.
##'
##' @name rw2
##' @docType data
##' @seealso \code{\link{pomp}}, \code{\link{ou2}}
##' @keywords datasets models
##' @examples
##'
##' pompExample(rw2)
##' plot(rw2)
##' x <- simulate(rw2,nsim=10,seed=20348585L,params=c(x1.0=0,x2.0=0,s1=1,s2=3,tau=1))
##' plot(x[[1]])
##'
NULL