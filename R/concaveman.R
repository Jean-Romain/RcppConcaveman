#' A very fast 2D concave hull algorithm
#'
#' The algorithm is based on ideas from Park and Oh (2012). A first implementation in JavaScript was
#' proposed by Vladimir Agafonkin in \href{https://github.com/mapbox/concaveman}{mapbox}. This
#' implementation dramatically improved performance over the one stated in the paper using a spatial
#' index. The algorithm was then ported to R by Joël Gombin in the R package
#' \href{https://github.com/joelgombin/concaveman}{concaveman} that runs the JavaScript implemetation
#' proposed by Vladimir Agafonkin. Later a C++ version of Vladimir Agafonkin's JavaScript implementation
#' was proposed by Stanislaw Adaszewski in \href{https://github.com/sadaszewski/concaveman-cpp}{concaveman-cpp}.
#' The concaveman function in RcppConcaveman package wraps the Stanislaw Adaszewski's C++ code making
#' the concaveman algorithm an order of magnitude (up to 50 times) faster than the Javascript version.
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
    if (!is.matrix(x) && !is.data.frame(x) && !is.list(x)) stop("A matrix a list or a data.frame is expected.")
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
