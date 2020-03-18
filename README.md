## RcppConcaveman

A very fast 2D concave hull algorithm in R

The algorithm is based on ideas from [Park and Oh (2012)](http://www.iis.sinica.edu.tw/page/jise/2012/201205_10.pdf). 

A first implementation in JavaScript was proposed by Vladimir Agafonkin in [mapbox](https://github.com/mapbox/concaveman). This implementation dramatically improved performance over the one stated in the paper (`O(rn)` to `O(n log n)`). 

The algorithm was then ported to R by Joël Gombin in the package [concaveman](https://github.com/joelgombin/concaveman). This package run the original implementation in JavaScript proposed by Vladimir Agafonkin using the `V8` library.

Later a C++ implementation of Vladimir Agafonkin's JavaScript was proposed by Stanislaw Adaszewski in [concaveman-cpp](https://github.com/sadaszewski/concaveman-cpp).

The `RcppConcaveman` package wraps the Stanislaw Adaszewski's C++ code and is a dependency free pakage.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(RcppConcaveman)
data(points)
hull <- concaveman(points)
plot(points, asp = 1)
lines(hull, lwd = 3, col = "red")
```

![](man/figure/concave.jpeg)

## Benchmarks

```r
microbenchmark::microbenchmark(
   cpp = RcppConcaveman::concaveman(x, y),
   js = concaveman::concaveman(m),
   times = 20)
```

#### 500 points

```
 Unit: milliseconds
  expr      min       lq     mean   median       uq      max neval
  cpp 11.85303 11.98518 12.98965 12.49173 12.87005 18.58301    20
   js 34.25240 35.26371 43.33496 40.81009 44.11052 78.52619    20
```

#### 1000 points

```
 Unit: milliseconds
  expr      min       lq     mean   median       uq      max neval
   cpp 28.89619 29.94671 32.72681 31.78227 35.66970 41.64685    20
    js 40.59757 43.78159 51.46020 48.41053 58.06069 75.52321    20
```

#### 2000 points

```
Unit: milliseconds
 expr      min       lq     mean   median       uq       max neval
  cpp 38.67958 39.03918 40.48053 39.67789 41.39601  45.16725    20
   js 43.91062 44.74566 57.17144 52.30814 59.67490 129.21173    20
```   

#### 4000 points

```
Unit: milliseconds
 expr      min       lq     mean   median       uq       max neval
  cpp 84.22761 85.10211 92.06418 89.48945 94.90472 114.76492    20
   js 57.45485 58.76846 66.08930 64.02365 69.80393  87.92922    20
```
