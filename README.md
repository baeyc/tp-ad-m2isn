# TPs du cours *Méthodes d'apprentissage* du M2 ISN

Vous trouverez sur ce dépôt Git les énoncés des TPs ainsi que leurs corrigés mis en ligne au fur et à mesure. Les TP sont préparés sous R.

  * [Comment ça marche ?](#how-to)
    + [Mode interactif](#mode-interactif)
    + [Mode non interactif](#mode-non-interactif)
  * [Séance 1 : Analyse factorielle discriminante](#tp-afd)
  * [Séance 2 : Analyse discriminante Gaussienne](#tp-adg)
  * [Séance 3 : Régression logistique](#tp-reglog)


<a name="how-to"></a>
## Comment ça marche ?
Pour chaque TP, il y a :
 - <img src="https://upload.wikimedia.org/wikipedia/commons/8/87/PDF_file_icon.svg" width=2%>  un énoncé au format PDF
 - <img src="https://upload.wikimedia.org/wikipedia/commons/4/48/Markdown-mark.svg" width=2%>  un fichier au format R Markdown
 - :open_file_folder: un dossier `data` global contenant les données utilisées dans les TP
 
 <a name="mode-interactif"></a>
### Mode interactif

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
```r
rmarkdown::run("nom_du_fichier.Rmd")
```
où, bien sûr, `nom_du_fichier` est à remplacer par le nom du TP correspondant. Une page web s'ouvre alors en local.
**Il faut bien penser à respecter la structure du dossier : mettre les fichiers de données dans un dossier `data` qui se trouve au même niveau que le fichier .Rmd. Si cela ne fonctionne toujours pas, il peut être nécessaire de lancer la commande suivante avant de faire le `rmarkdwon::run()` :**
```r
setwd("nom_du_repertoire_contenant_le_dossier_data_et_le_fichier_Rmd") # pour préciser où chercher les fichiers
```

:heavy_exclamation_mark:***Attention*** : le package `learnr`, utilisé pour construire les TP interactifs, fonctionne avec des exercices indépendants les uns des autres. Plus précisément, cela signifie que chaque fenêtre de code est exécutée sans tenir compte des autres, et donc aucune des variables ou des objets créés dans une fenêtre précédente ne seront accessibles. Deux solutions à cela : 
 - une fois que l'on a obtenu ce qu'il fallait dans une fenêtre donnée, copier-coller ce code dans la fenêtre suivante. Il sera alors exécuté à nouveau et accessible. **Si vous choisissez cette option, tenez compte du fait que tous les calculs basés sur un échantillonnage aléatoire pourront donner des résultats différents quand ils seront lancés depuis deux fenêtres différentes. Pour obtenir les même résultats que ceux des fenêtres précédentes, pensez alors à fixer la graine du générateur aléatoire**.
 - tout coder en une seule fois, sur une seule grande fenêtre. J'ai ajouté une fenêtre pour cela à la fin de chaque exercice, en bas de page.

 <a name="mode-non-interactif"></a>
### Mode non interactif
Il suffit de suivre les instructions du fichier pdf.


 <a name="tp-afd"></a>
## Séance 1 : Analyse factorielle discriminante
### *11 septembre 2020, de 10h à 12h*

*Nom du fichier* : TP_analyse_factorielle_discriminante_2

Lien vers le TP interactif : https://baeyc.shinyapps.io/tp_analyse_factorielle_discriminante_2/

Trois exercices pour se familiariser avec l'analyse factorielle discriminante.

 <a name="tp-adg"></a>
## Séance 2 : Analyse discriminante Gaussienne
### *18 septembre 2020, de 10h à 12h*

*Nom du fichier* : TP_analyse_discriminante_gaussienne

Deux exercices, sur données artificielles et données réelles, pour comparer le cas homoscédastique et le cas hétéroscédastique (frontière de décision, parcimonie, ...)

 <a name="tp-reglog"></a>
## Séance 3 : Régression logistique
### *9 octobre 2020, de 10h à 12h*

*Nom du fichier* : TP_regression_logistique

Deux exercices sur la régression logistique (binaire, et polytomique).
