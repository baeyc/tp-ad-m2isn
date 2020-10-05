import pandas as pd
import numpy as np
from matplotlib.colors import ListedColormap
import matplotlib.pyplot as plt
import seaborn as sns
import itertools

import sklearn
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis, QuadraticDiscriminantAnalysis

## Exo 1
# importation de la base de données
d1 = pd.read_table("data/data1_adg.txt", index_col=False, sep=" ")
d1.head()

# Plot
sns.scatterplot(data=d1, x='x1', y='x2', hue='group')

# analyse factorielle discriminante
d1.lda = LinearDiscriminantAnalysis().fit(d1[['x1','x2']],d1[['group']])
pred = d1.lda.predict(d1[['x1','x2']])

# matrice de confusion
mc = sklearn.metrics.confusion_matrix(d1[['group']],pred)
# taux de bien classés et de mal classés
txbc = np.sum(np.diag(mc))/np.sum(mc)
txmc = 1 - txbc

# Grille
x_min, x_max = d1.x1.min() - .5, d1.x1.max() + .5
y_min, y_max = d1.x2.min() - .5, d1.x2.max() + .5
h = 0.02
xx, yy = np.meshgrid(np.arange(x_min, x_max, h),np.arange(y_min, y_max, h))

predgrid = d1.lda.predict(np.c_[xx.ravel(), yy.ravel()])

cm = ListedColormap(['#FF0000', '#0000FF'])
ax = plt.subplot()
predgrid = predgrid.reshape(xx.shape)
ax.contourf(xx,yy,predgrid, cmap=cm, alpha=0.1)
ax.scatter(d1['x1'],d1['x2'],c=d1['group'], cmap=cm)
plt.show()

