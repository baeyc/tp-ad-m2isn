# TP analyse discriminante gaussienne

# Exo 1
library(MASS)
library(ade4)

## Importer les données
data1 <- read.table("data/data1_adg.txt", header = TRUE)
data2 <- read.table("data/data2_adg.txt", header = TRUE)


## Description, visualisation
summary(data1)

# Plot x2 en fonction de x1, colore les points en fonction du groupe
plot(data1$x1,data1$x2,pch=19,col=data1$group)

# Même chose mais avec la librairie ggplot
library(ggplot2)
ggplot(data=data1,aes(x=x1,y=x2,color=as.factor(group))) + 
  geom_point(size=3) + scale_color_discrete("Group")


## Analyse discriminante gaussienne
# on transforme la variable group en "factor", ce qui garantit qu'elle sera bien traitée comme une variable
# qualitative par R par la suite (recommandé)
data1$group <- as.factor(data1$group)
summary(data1) # on remarque que cela change les calculs faits par la fonction summary

# Analyse gaussienne homoscédastique -> "linéaire" donc fonction lda
d1.lda <- lda(group~x1+x2,data=data1)
pred1_lda <- predict(d1.lda) # applique le modèle aux données

# Analyse gaussienne hétéroscédastique -> "quadratique" donc fonction qda
d1.qda <- qda(group~.,data=data1)
pred1_qda <- predict(d1.qda) # applique le modèle aux données


## Frontière de décision
# 300 points régulièrement espacés entre -2 et 7
xgrille <- seq(-2,7,length.out = 300)
# de même entre 0 et 5
ygrille <- seq(0,5,length.out = 300)

# on créé un jeu de données contenant les coordonnées de tous les points de la grille
grille <- expand.grid(xgrille,ygrille)
# pour pouvoir appliquer le modèle précédemment construit avec lda ou qda, il faut absolument que les variables aient le même nom
# (sinon R ne peut pas savoir quelle colonne contient les valeurs de la variable qui s'appelait x1 dans le modèle, etc.)
names(grille) <- c("x1","x2")

# on applique le modèle précédent, mais cette fois sur les nouvelles données de la grille
lda.grille <- predict(d1.lda,newdata = grille)
qda.grille <- predict(d1.qda,newdata = grille)

# On trace le résultat
plot(data1$x1,data1$x2,pch=19,col=data1$group)
points(grille$x1,grille$x2,col=lda.grille$class,pch=".") # pour superposer des points à un graphe déjà existant

plot(data1$x1,data1$x2,pch=19,col=data1$group)
points(grille$x1,grille$x2,col=qda.grille$class,pch=".")

## avec ggplot
dgrille <- rbind(grille,grille)
dgrille$group <- c(lda.grille$class,qda.grille$class)
dgrille$method <- rep(c("Homoscédastique","Hétéroscédastique"),each=nrow(grille))

library(ggplot2)
ggplot(data=dgrille,aes(x=x1,y=x2,color=as.factor(group))) + geom_point(alpha=0.05) +
  geom_point(data=data1,size=3) + scale_color_discrete("Groupe") + facet_wrap(~method)



# Jeu de données 2 (même démarche)
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
data <- read.csv("data/diabetes.csv",header=TRUE) # ne pas oublier header=TRUE !!

# Pour vérifier que l'importation s'est bien passée, plusieurs possibilités :
head(data) # affiche les premières lignes, on peut ainsi visualiser que les variables ont bien été interprétées
summary(data) # statistiques descriptives, on peut aussi voir rapidement s'il y a eu un problème
str(data) # affiche la structure du jeu de données

# on transforme la variable Y qui représente le groupe à prédire (ici Outcome) en variable de facteur
data$Outcome <- as.factor(data$Outcome)


# Création de base de test et d'apprentissage (voir TP 1 pour solution sans passer par dplyr)
library(dplyr)
data <- data %>% mutate(id = row_number()) 
data.appr <- data %>% sample_frac(0.80) 
data.test  <- anti_join(data, data.appr, by = 'id')
data.appr <- data.appr %>% select(!c(id))
data.test <- data.test %>% select(!c(id))


# Analyse discriminante Gaussienne homoscédastique
diab.lda <- lda(Outcome ~ ., data=data.appr)

# Matrice de confusion
# la fonction "table" permet de croiser deux variables qualitatives
mc.lda <- table(data.appr$Outcome,predict(diab.lda)$class)
sum(diag(mc.lda))/sum(mc.lda) # calcule le taux de bien classés (ceux sur la diagonale)

# Même chose sur la base de test
test.pred <- predict(diab.lda,newdata = data.test)
mctest <- table(data.test$Outcome,test.pred$class)
sum(diag(mctest))/sum(mctest)


# Modèle de mélange hétéroscédastique
diab.qda <- qda(Outcome ~ ., data=data.appr)

mc.qda <- table(data.appr$Outcome,predict(diab.qda)$class)
sum(diag(mc.qda))/sum(mc.qda)

test.pred2 <- predict(diab.qda,newdata = data.test)
mctestqda <- table(data.test$Outcome,test.pred2$class)
sum(diag(mctestqda))/sum(mctestqda)

