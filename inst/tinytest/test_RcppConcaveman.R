data(points)

n = if (.Machine$sizeof.pointer == 4L) 284 else 200

# It works ?
pts = points
hull <- concaveman(pts)
expect_equal(dim(hull), c(n,2))
expect_equivalent(hull[1,], hull[n,])

# It works with 3 points
pts = points[1:3,]
hull <- concaveman(pts)
expect_equal(dim(hull), c(4,2))
expect_equivalent(hull[1,], hull[4,])

# It does not work with < 3 points
pts = points[1:2,]
expect_error(concaveman(pts))

# It works with data.frame
pts = as.data.frame(points)
hull <- concaveman(pts)
expect_equal(dim(hull), c(n,2))
expect_equivalent(hull[1,], hull[n,])

# It works with vectors
x = points[,1]
y = points[,2]
hull <- concaveman(x, y)
expect_equal(dim(hull), c(n,2))
expect_equivalent(hull[1,], hull[n,])

# Large concavity result in convex hull
hull <- concaveman(points, concavity = 1e8)
expect_equal(dim(hull), c(12,2))
expect_equivalent(hull[1,], hull[12,])
