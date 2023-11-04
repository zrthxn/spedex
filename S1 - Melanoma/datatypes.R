## Basic Primitive Types

x <- 8

x <- "Hello there"

x # implicit print
print(x) # explicit print

x <- c(1, 2, 3, 4, 5)
x <- TRUE
x

# <- is the assignment operator but 
# in this stupid language = also works!
x = 420

x <- date()

x <- c(10:45)
length(x)

## Matrices and Arrays

# generates a matrix with four rows and three columns
# and fills it with numbers from 1 to 12
m <- matrix(1:12, nrow = 4, ncol = 3)
m

m[,2]
m[2:3,]
m[2:4,1:3]

