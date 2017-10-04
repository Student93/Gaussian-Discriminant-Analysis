# Gaussian-Discriminant-Analysis

Implement GDA for separating out salmons from Alaska and Canada. Each salmon is represented by two attributes x1 and x2 depicting growth ring diameters in 1) fresh water, 2) marine water, respectively.


It is observed that the quadratic boundary is a better separator than the linear boundary.
Quadratic boundary gives less wrong prediction than linear boundary
on the training data.

Linear separator assumes that both the classes have the same co-variance matrix which is not true in most of the cases as both different class generally have items which are not related to each
other and assuming that they vary in the same manner doesn’t sounds to be a good startegy for most of the cases.

With Covariace matrix different for both classes, Quadratic GDA represents a more general case which can handle data very well even if it’s lineraly separatable.