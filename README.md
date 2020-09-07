# TPs du cours *Méthodes d'apprentissage* du M2 ISN

Vous trouverez sur ce dépôt Git les énoncés des TPs ainsi que leurs corrigés mis en ligne au fur et à mesure. Les TP sont préparés sous R.

## Comment ça marche ?
Les TP interactifs ont été réalisés sous R Shiny et ont été déployés sur shinyapps.io. Ils sont accessibles directement depuis l'url mentionné ci-dessous. En cas de problème, par exemple si le serveur est surchargé, il est possible de lancer le TP en local.
Pour cela, il faut tout d'abord installer les packages suivants :
 - learnr
 - fontawesome
 - dplyr
 - MASS
 - ggplot2
 - rmarkdown
 - knitr
 
Puis, à partir de la console de [RStudio](https://rstudio.com/), on peut lancer :
```
rmarkdown::run("nom_du_fichier.Rmd")
```
où, bien sûr, `nom_du_fichier` est à remplacer par le nom du TP correspondant. Une page web s'ouvre alors en local.

## Séance 1 : Analyse factorielle discriminante
### *11 septembre 2020, de 10h à 12h*

*Nom du fichier* : TP_analyse_factorielle_discriminante_2"

Trois exercices pour se familiariser avec l'analyse factorielle discriminante.
