##' obs
##'
##' Extract the data array from a \sQuote{pomp} object.
##'
##' @name obs
##' @docType methods
##' @rdname obs
##' @include pomp_class.R
##' @importFrom stats setNames
##'
NULL

setGeneric(
    "obs",
    function (object, ...)
        standardGeneric("obs")
)

##' @name obs-pomp
##' @aliases obs obs,pomp-method
##' @rdname obs
##' @param object an object of class \sQuote{pomp}, or of a class extending \sQuote{pomp}
##' @param vars names of variables to retrieve
##' @param \dots ignored
##'
##' @export
setMethod(
  "obs",
  signature=signature(object="pomp"),
  definition=function (object, vars, ...) {
    varnames <- rownames(object@data)
    if (missing(vars))
      vars <- varnames
    else if (!all(vars%in%varnames))
      pStop("obs","some elements of ",
        sQuote("vars")," correspond to no observed variable.")
    y <- object@data[vars,,drop=FALSE]
    dimnames(y) <- setNames(list(vars,NULL),c("variable","time"))
    y
  }
)
