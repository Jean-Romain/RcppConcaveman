## RcppConcaveman

A very fast 2D concave hull algorithm in R

The algorithm is based on ideas from [Park and Oh (2012)](http://www.iis.sinica.edu.tw/page/jise/2012/201205_10.pdf). 

A first implementation in JavaScript was proposed by Vladimir Agafonkin in [mapbox](https://github.com/mapbox/concaveman). This implementation dramatically improved performance over the one stated in the paper using a spatial index. 

The algorithm was then ported to R by Joël Gombin in the package [concaveman](https://github.com/joelgombin/concaveman). This package run the JavaScript implemetation proposed by Vladimir Agafonkin using the `V8` library wrapped in the [V8 package](https://CRAN.R-project.org/package=V8).

Later a C++ version of Vladimir Agafonkin's JavaScript implementation was proposed by Stanislaw Adaszewski in [concaveman-cpp](https://github.com/sadaszewski/concaveman-cpp).

The `RcppConcaveman` package wraps the Stanislaw Adaszewski's C++ code making the concaveman algorithm an order of magnitude faster than the Javascript version. Moreover the package is a dependency free (it depends only on `Rcpp`).

## Example

```r
library(RcppConcaveman)
data(points)
hull <- concaveman(points)
plot(points, asp = 1)
lines(hull, lwd = 3, col = "red")
```

![](https://raw.githubusercontent.com/Jean-Romain/RcppConcaveman/master/man/figure/concave.jpeg)

## Benchmarks

The following benchmarks were computed with randomly generated points. The bars show the computation times of `RcppConcaveman` in pink and `concaveman` in blue. The black lines shows the relative speed. A value of 10 means that the C++ version is 10 times faster than the Javascript version.

![](https://raw.githubusercontent.com/Jean-Romain/RcppConcaveman/master/man/figure/timing.jpeg)
