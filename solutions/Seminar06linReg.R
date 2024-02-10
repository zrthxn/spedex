data(faithful);    ### download the Old-faithful data set from R
attach(faithful);  ### to make columns available by name 
                   ### (no need to name them differently,
hist(waiting);
boxplot(waiting);
plot(eruptions ~ waiting);
   ## Scatterplot:  x-axis - waiting
mod.faithful <- lm(eruptions ~ waiting)   ## Simple linear regression 
summary(mod.faithful) ## summary of the model fit
abline(mod.faithful,col="red",lwd=2)  ## add the regression line to the scatterplot
#mod.faithful$residuals        ## to see the residuals
#mod.faithful$fitted.values    ## to see the fitted values
plot(mod.faithful$fitted.values, mod.faithful$residuals,
     xlab="fitted values",ylab="residuals")  ## residuals vs fitted values
abline(h=0,col="red",lwd=2)           ## to add the horizontal line
qqnorm(mod.faithful$residuals)   ## QQ plot of the residuals
qqline(mod.faithful$residuals,col="red",lwd=2)   

waiting.less3 <- subset(faithful$waiting, faithful$eruptions <3)
waiting.greater3 <- subset(faithful$waiting, faithful$eruptions >=3)
boxplot(waiting.less3,waiting.greater3)
### to compare mean wating time between two groups, we can use t-test:
t.test(waiting.less3,waiting.greater3)  
## The comparison can also be conducted using a linear regression model.
## In order to do this, we need to add an indicator variable 
## which is equal to 0 for one group 
## and to 1 for the other:
time <- c(rep(0,length(waiting.less3)),rep(1,length(waiting.greater3))) 
## We also create a new data set with two columns:
wait <- c(waiting.less3,waiting.greater3)
## Fit the regression model (response = waiting time, predictor = group)
mod.wait <- lm(wait~time)
## F-test to see whether there is a difference between two group means:
anova(mod.wait)  
summary(mod.wait) 



data(faithful)   ### download the old-faithful data set from R
faithful.less3 <- subset(faithful, faithful$eruptions <3)
mod <- lm(eruptions ~ waiting, data=faithful.less3)
y.fitted <- mod$fitted.values;
y.residuals <- mod$residuals;
my.seed <- 1234;
Nsim <- 100;
wait.estim <- matrix(0, nrow = Nsim,ncol=2); ## we will collect the estimates in this matrix
for(i in 1:Nsim)
{
   set.seed(my.seed+i);
   new.residuals <- sample(y.residuals, length(y.residuals),replace=TRUE);
   y.new <- y.fitted + new.residuals;
   mod.new <- lm(y.new ~ faithful.less3$waiting);
   wait.estim[i,] <- summary(mod.new)$coef[,1];
}
 
t.test(wait.estim[,1])  ## to obtain a bootstrap estimate and conf.int. for the intercept
t.test(wait.estim[,2])  ## to obtain a bootstrap estinmate and conf.int. for the slope
