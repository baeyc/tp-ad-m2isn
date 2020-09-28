# TP analyse discriminante gaussienne

# Exo 1
# train1 <- rmvnorm(60,c(3,2),sigma=diag(c(2,0.5,0.5,1),nr=2))
# train1 <- rbind(train1,rmvnorm(40,c(1,3),sigma=diag(c(1,0.15,0.15,0.5),nr=2)))
# train1 <- as.data.frame(train1)
# train1$group <- c(rep("1",60),rep("2",40))
# plot(train1$V1,train1$V2,col=train1$group)
# names(train1) <- c("x1","x2","group")
# write.table(train1,"~/Documents/Enseignement/Lille/M2 ISN/Analyse de données/TP/tp-ad-m2isn/data/data1_adg.txt",row.names = F,quote = F)
# # 
# train <- circles(100)
# plot(train)
# names(train) <- c("x1","x2","group")
# train$group <- train$group+1
# write.table(train,"~/Documents/Enseignement/Lille/M2 ISN/Analyse de données/TP/tp-ad-m2isn/data/data2_adg.txt",row.names = F,quote = F)









library(MASS)
library(ade4)




## Importer les données

data1 <- read.table("data/data1_adg.txt", header = TRUE)
data2 <- read.table("data/data2_adg.txt", header = TRUE)



## Description, visualisation
summary(data1)
plot(data1$x1,data1$x2,pch=19)

plot(data1$x1,data1$x2,pch=19,col=data1$group)

library(ggplot2)
ggplot(data=data1,aes(x=x1,y=x2,color=as.factor(group))) + 
  geom_point(size=3) + scale_color_discrete("Group")


## Analyse discriminante gaussienne
data1$group <- as.factor(data1$group)
summary(data1)

d1.lda <- lda(group~x1+x2,data=data1)
pred1_lda <- predict(d1.lda)

d1.qda <- qda(group~.,data=data1)
pred1_qda <- predict(d1.qda)



## Frontière de décision



# 300 points régulièrement espacés entre -2 et 7
xgrille <- seq(-2,7,length.out = 300)
# de même entre 0 et 5
ygrille <- seq(0,5,length.out = 300)



grille <- expand.grid(xgrille,ygrille)
names(grille) <- c("x1","x2")

lda.grille <- predict(d1.lda,newdata = grille)
qda.grille <- predict(d1.qda,newdata = grille)

plot(data1$x1,data1$x2,pch=19,col=data1$group)
points(grille$x1,grille$x2,col=lda.grille$class,pch=".")

plot(data1$x1,data1$x2,pch=19,col=data1$group)
points(grille$x1,grille$x2,col=qda.grille$class,pch=".")

## avec ggplot
dgrille <- rbind(grille,grille)
dgrille$group <- c(lda.grille$class,qda.grille$class)
dgrille$method <- rep(c("Homoscédastique","Hétéroscédastique"),each=nrow(grille))

library(ggplot2)
ggplot(data=dgrille,aes(x=x1,y=x2,color=as.factor(group))) + geom_point(alpha=0.05) +
  geom_point(data=data1,size=3) + scale_color_discrete("Groupe") + facet_wrap(~method)



# Jeu de données 2
d2.lda <- lda(group~.,data=data2)
pred2_lda <- predict(d2.lda)

d2.qda <- qda(group~.,data=data2)
pred2_qda <- predict(d2.qda)

plot(data2$x1,data2$x2,pch=19,col=data2$group)

xgrille <- seq(-3,3,length.out = 300)
ygrille <- seq(-3,3,length.out = 300)
grille <- expand.grid(xgrille,ygrille)
names(grille) <- c("x1","x2")

lda.grille <- predict(d2.lda,newdata = grille)
qda.grille <- predict(d2.qda,newdata = grille)

plot(data2$x1,data2$x2,pch=19,col=data2$group)
points(grille$x1,grille$x2,col=lda.grille$class,pch=".")

plot(data2$x1,data2$x2,pch=19,col=data2$group)
points(grille$x1,grille$x2,col=qda.grille$class,pch=".")


dgrille <- rbind(grille,grille)
dgrille$group <- c(lda.grille$class,qda.grille$class)
dgrille$method <- rep(c("Homoscédastique","Hétéroscédastique"),each=nrow(grille))

library(ggplot2)
ggplot(data=dgrille,aes(x=x1,y=x2,color=as.factor(group))) + geom_point(alpha=0.05) +
  geom_point(data=data2,size=3) + scale_color_discrete("Groupe") + facet_wrap(~method)


# Exo 2 (R)
data <- read.csv("data/diabetes.csv",header=TRUE)
head(data)
summary(data)
str(data)
data$Outcome <- as.factor(data$Outcome)




library(dplyr)
data <- data %>% mutate(id = row_number()) 
data.appr <- data %>% sample_frac(0.80) 
data.test  <- anti_join(data, data.appr, by = 'id')
data.appr <- data.appr %>% select(!c(id))
data.test <- data.test %>% select(!c(id))




diab.lda <- lda(Outcome ~ ., data=data.appr)


# Matrice de confusion
mc <- table(data.appr$Outcome,predict(diab.lda)$class)
sum(diag(mc))/sum(mc)

test.pred <- predict(diab.lda,newdata = data.test)

mctest <- table(data.test$Outcome,test.pred$class)
sum(diag(mctest))/sum(mctest)


# Modèle de mélange hétéroscédastique
diab.qda <- qda(Outcome ~ ., data=data.appr)

mc2 <- table(data.appr$Outcome,predict(diab.qda)$class)
sum(diag(mc2))/sum(mc2)

test.pred2 <- predict(diab.qda,newdata = data.test)
mctest2 <- table(data.test$Outcome,test.pred2$class)

sum(diag(mctest2))/sum(mctest2)



## Exo 2019 et antérieur
# 
# cranes <- read.table("~/Documents/Enseignement/Lille/M2 ISN/AD/TP/Data/cranes.txt",header=TRUE)
# 
# # Calcul de la moyenne dans chaque groupe
# mu1 <- apply(cranes[cranes$type==1,3:8],2,mean)
# mu2 <- apply(cranes[cranes$type==2,3:8],2,mean)
# 
# # Calcul de la matrice de covariance empirique dans chaque groupe
# cov1 = cov(na.omit(cranes[cranes$type==1,3:8]))
# cov2 = cov(na.omit(cranes[cranes$type==2,3:8]))
# 
# # 1. Cas homoscédastique : frontière linéaire
# # Estimation de la matrice de covariance poolée
# # on multiplie chaque matrice cov1 et cov21 par 29 et 11 respectivement, car la fonction "cov" de R
# # renvoie par défaut 1/(n-1)sum_{i=1}^n (x_i - mu)(x_i - mu)'
# Sigma <- (1/40)*(29*cov1 + 11*cov2)
# 
# # proportion d'individus dans chaque groupe
# p1 <- mean(na.omit(cranes$type)==1)
# p2 <- mean(na.omit(cranes$type)==2)
# 
# # Fonction qui renvoie les paramètres associés à la fonction discriminante dans chaque groupe
# # En se basant sur les notations du cours, cela revient à calculer séparément le log du numérateur et le log
# # du dénominateur de la fonction g(x) -> c'est ce que renvoie SAS dans sa sortie "Linear discriminant function"
# para.lin.pargroup <- function(mu1,mu2,Sigma,p1,p2)
# {
#   return(list(p1=list(coefs=t(mu1)%*%solve(Sigma),cst=-0.5*t(mu1)%*%solve(Sigma)%*%mu1+log(p1)),
#               p2=list(coefs=t(mu2)%*%solve(Sigma),cst=-0.5*t(mu2)%*%solve(Sigma)%*%mu1+log(p2))))
# }
# 
# # Fonction qui renvoie les paramètres de la fonction G(x) -> on retrouve les coefficients donnés par SAS
# # dans la sortie "Linear discriminant function" si on fait la somme par ligne.
# para.lin  <- function(mu1,mu2,Sigma,p1,p2)
# {
#   return(list(coefs=t(mu1-mu2)%*%solve(Sigma), cst=-0.5*t(mu1-mu2)%*%solve(Sigma)%*%(mu1+mu2)+log(p1/p2)))
# }
# 
# 
# # 2. Cas hétéroscédastique : frontière quadratique
# # RQ : le premier terme correspond à (x^t)Sigma_2^{-1}x - (x^t)Sigma_2^{-1}x  que l'on obtient en développant l'expression
# # initiale. On peut la factoriser en : (x^t)(Sigma_2^{-1} - Sigma_2^{-1})x 
# # et on remarque que cette quantité est dans R, donc en particulier elle est égale à sa trace. Or, comme tr(AB)=tr(BA), 
# # cela nous permet d'écrire le premier terme comme tr((Sigma_2^{-1} - Sigma_2^{-1}) x(x^t)), c'est-à-dire que l'on calcule
# # la matrice (Sigma_2^{-1} - Sigma_2^{-1}), que l'on multipliera par x(x^t), et que l'on prendra ensuite la trace de ce produit
# para.quad <- function(mu1,mu2,Sigma1,Sigma2,p1,p2)
# {
#   return(list(coefsxxt=(solve(Sigma2)-solve(Sigma1)), 
#               coefsx=2*(t(mu1)%*%solve(Sigma1) - t(mu2)%*%solve(Sigma2)), 
#               cst=t(mu2)%*%solve(Sigma2)%*%mu2-t(mu1)%*%solve(Sigma1)%*%mu1+log(det(Sigma2)/det(Sigma1))+2*log(p1/p2)))
# }
# 
# para.quad(mu1,mu2,(29/30)*cov1,(11/12)*cov2,p1,p2)
# 
# 
# # Calcul de la fonction discriminante (linéaire ou quadratique) pour classer l'individu sans classe
# # Pour obtenir l'équation de la surface discriminante en un point x donné, on fait :
# x <- as.numeric(cranes[43,3:8]) # on récupère les valeurs des variables pour l'individu sans classe (ligne 43 du fichier)
# # la fonction "as.numeric" sert ici à convertir x en un vecteur numérique, car par défaut en extrayant une ligne d'un dataset
# # il semblerait que R l'interprète comme une list, ce qui pose problème ensuite pour le calcul matriciel)
# 
# param_lin <- para.lin(mu1,mu2,Sigma,p1,p2)
# discrimin_lin <- param_lin$cst + param_lin$coefs%*%x
# 
# param_quad <- para.quad(mu1,mu2,(29/30)*cov1,(11/12)*cov2,p1,p2)
# # Remarque : on a besoin de calculer la trace, qui n'est autre que la somme des éléments diagonaux.
# # La fonction diag permet d'extraire la diagonale d'une matrice.
# discrimin_quad <- param_quad$cst + param_quad$coefsx%*%x + sum(diag(param_quad$coefsxxt%*%x%*%t(x))) 
