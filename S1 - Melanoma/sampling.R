library("ggplot2")

## Density function for a normally distributed random variable
f_den <- function(x, u = 52, ss = 4) {
  1 / (sqrt(2 * pi * (ss))) * exp(-((x - u)^2) / (2 * (ss)))
}

# The activity of the protein catalase in healthy
# murine liver cells (measured in enzyme units) under some fixed
# conditions can be modelled as normally distributed with expectation 𝜇=52
# and variance 𝜎2=4 (cf. Seminar 1a). The density function 𝑓 of this normal 
# distribution at the value 𝑥=53 evaluates to ??.

f_den(53, 52, 4)
x <- c(30:60)
plot(f_den(x) ~ x)

# Test
f_den(c(47, 50, 52, 54, 55), 52, 4)


## Probability is the area under the density curve

# The probability that the protein activity less than 54 is
integrate(f_den, 0, 54)

# The probability that the protein activity has a value between 48 and 56 is ??
integrate(f_den, 48, 56)


## Taking Samples

# In the seminar (cf. Seminar 1a) you have generated a sample of data in R
# from the assumed normal distribution via the commands:
set.seed(12345)
x <- rnorm(57, mean = 52, sd = 2)

# Mean
# The mean of the sample data in vector x is ??
mean(x)

# Variance
# The variance of the sample data in vector x is ??
var(x)
