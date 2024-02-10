##TitanicExample
  
library(alr4)
library(emmeans)
## To fit a logistic regression model:
m1 <- glm(survived ~ age + sex + passengerClass,
          family="binomial", data = TitanicSurvival);
summary(m1);
## predicted values for the 1st class passengers:
#predict(m1,newdata = subset(TitanicSurvival, 
#                            TitanicSurvival$passengerClass == "1st"));

## To get average values for log odds of survival and 
## their contrasts (log odds ratios):

## The odds of survival by gender:
emmeans(m1, pairwise ~ sex)$contrasts;
## female passengers have higher odds of survival
exp(2.5);  ## their odds are 12 times higher than those of men

## The odds of survival by passenger class:
emmeans(m1, pairwise ~ passengerClass)$emmeans;
## First Class passengers have the highest odds of survival

## To add the Class*Sex interaction:
m2 <- glm(survived ~ age + sex + passengerClass + 
            passengerClass*sex,family="binomial",
          data = TitanicSurvival);
summary(m2);
## Analysis of deviance:
anova(m1, m2, test = "Chisq");

## Odds of survival by sex:
emmeans(m2, pairwise ~ sex)$emmeans;
## Difference in odds of survival by sex:
emmeans(m2, pairwise ~ sex)$contrasts;
exp(3.08); ## by how much higher

## Class effects by Sex:
emmeans(m2, pairwise ~ passengerClass|sex)$contrasts;

## Males in the first class versus males in the third class:
## contrast = 1.5762

## odds ratio:

exp(1.5762);  ## the odds are about 4.8 times higher.


##Agresti
  
duration<-c(45,15,40,83,90,25,35,65,95,35,75,45,50,75,
              30,25,20,60,70,30,60, 61,65,15,20,45,15,25,
              15,30,40,15,135,20,40);
type<-c("M","M","M","T","T","T",rep("M",5),"T","T","T","M","M","T","T","T",
        rep("M",4),"T","T","M","T","M","T","M","M",rep("T",4));
sore<-c(0,0,rep(1,10),0,1,0,1,0,rep(1,4),0,1,0,0,1,0,1,0,1,1,0,1,0,0);
sore.fr<-as.data.frame(cbind(duration, type, sore));
xtabs(~sore+type,data=sore.fr);

options(contrasts = c("contr.treatment","contr.poly"));

## a binomial glm with interaction: 
m1<-glm(sore ~ type*duration, family=binomial);
summary(m1, cor=T);
m2<-glm(sore ~ type+duration, family=binomial);

anova(m1,m2, test = "LRT")

##The   high   negative   correlation   between   duration   and   the   intercept   
# can   be   reduced   by   standardizing duration: 
sorethroat.lg<-glm(sore ~ type*scale(duration), family=binomial); 
summary(sorethroat.lg) 
## The interaction does not appear significant based on the Wald test.  
## A LRT of the interaction parameter gives
sorethroat.lg2<-glm(sore ~ type + scale(duration), family=binomial); # no interaction 
anova(sorethroat.lg2, sorethroat.lg, test = "Chisq");
anova(sorethroat.lg2, sorethroat.lg, test = "F");
## An interaction may not really be present, so choose the model with only main effects.
## How the coefficients are interpreted:
summary(sorethroat.lg2) 
coef(sorethroat.lg2)
exp(1.739875) ## odds of sore=1 /sore = 0 for the Baseline type (= Mask), 
## duration = fixed
exp(1.739875)/(1+exp(1.739875)) ## 0.85 = probability of having sore = 1 for type = M, 
## duration = 0
exp(1.739875-1.658949) ## odds of sore=1 /sore = 0 for group = Tube, duration = fixed
exp(1.739875-1.658949)/(1+exp(1.739875-1.658949)) ## 0.52  = probability of sore = 1, type = T,
## duration = 0
exp(-1.658949) ## 0.19 = odds ratio 
exp(1.658949) ## 5.25 = odds ratio, Mask group is 5 times more likely than T group has sore=1 


##
prostate <- read.table("prostate.dat", header = TRUE);
cor(prostate[,1:9]); ## correlation matrix
pairs(prostate[,1:9], col="darkblue"); ## correlation plot
scaled.prostate <- as.data.frame(scale(prostate[,1:8]));  ## scaling predictors 
scaled.prostate$lpsa <- prostate$lpsa; ## to attach the response
head(scaled.prostate);
## Fit linear regression to these data:
mod.1 <- lm(lpsa ~ lcavol+lweight+age+lbph+
              svi+lcp+gleason+pgg45, subset(scaled.prostate, prostate$train == TRUE));
summary(mod.1);

mod.2 <- lm(lpsa ~ lcavol+lweight+lbph+
              svi+lcp+pgg45, subset(scaled.prostate, prostate$train == TRUE));
anova(mod.2,mod.1)

mod.3 <- lm(lpsa ~ lcavol+lweight+lbph+
              svi+pgg45, subset(scaled.prostate, prostate$train == TRUE));
anova(mod.3,mod.2)

  
  