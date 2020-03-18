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
  expr      min       lq     mean   median       uq      max neval
   cpp 61.70749 61.97916 63.68702 62.60480 63.22871 75.79339    20
    js 48.82641 50.15727 59.98756 52.02225 67.56326 90.68871    20
```   

#### 4000 points

```
Unit: milliseconds
 expr      min        lq      mean    median        uq      max neval
  cpp 109.2677 110.08687 115.35193 111.91904 120.02852 136.1379    20
   js  67.1860  71.15402  80.85412  73.83894  87.01278 118.3171    20
```
