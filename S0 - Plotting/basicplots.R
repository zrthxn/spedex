# Plotting some diamong data using the
# stock/inbuilt plotting capabilities of R

set.seed(1289)

data(diamonds, package = "ggplot2")
summary(diamonds)

# randomly sample 20 observations per group defined by color & cut
df <- diamonds |> dplyr::slice_sample(n = 20, by = c(color, cut))

# Basic plots
plot(price ~ carat, data = df)
plot(depth ~ z, data = df)

# Implicit boxplot
plot(price ~ color, data = df)

# Explicit boxplot
boxplot(price ~ cut, data = df)