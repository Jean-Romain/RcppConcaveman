#' A very fast 2D concave hull algorithm
#'
#' The algorithm is based on ideas from Park and Oh (2012) (see references) and was first implement
#'
#' @param x,y coordinate vectors of points. This can be specified as two vectors x and y, a 2-column
#' matrix x, a list x with two components, etc.
#' @param concavity numeric a relative measure of concavity. 1 results in a relatively detailed shape,
#' Infinity results in a convex hull. You can use values lower than 1, but they can produce pretty crazy
#' shapes.
#' @param lengthThreshold numeric. when a segment length is under this threshold, it stops being
#' considered for further detalization. Higher values result in simpler shapes.
#'
#' @references A New Concave Hull Algorithm and Concaveness Measure for n-dimensional Datasets, 2012
#' by Jin-Seo Park and Se-Jong Oh. https://www.iis.sinica.edu.tw/page/jise/2012/201205_10.pdf
#' @export
#' @examples
#' data(points)
#' hull <- concaveman(points)
#' plot(points, asp = 1)
#' lines(hull, lwd = 3, col = "red")
concaveman <- function(x, y = NULL, concavity = 2, lengthThreshold = 0) {

  stopifnot(is.numeric(concavity), is.numeric(lengthThreshold), length(concavity) == 1L, length(lengthThreshold) == 1L)

  if (is.null(y)) {
    if (!is.matrix(x) && !is.data.frame(x)) stop("A matrix or a data.frame is expected.")
    if (dim(x)[2] != 2) stop("Two columns are expected.")
    if (is.matrix(x)) {
      y <- x[,2]
      x <- x[,1]
    } else {
      y <- x[[2]]
      x <- x[[1]]
    }
  }

  stopifnot(is.numeric(x), is.numeric(y), length(x) == length(y), length(x) >= 3L)

  h <- grDevices::chull(x, y) - 1
  return(cpp_concaveman(x, y, concavity, lengthThreshold, h))
}
