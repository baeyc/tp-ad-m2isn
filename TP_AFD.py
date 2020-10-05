import pandas as pd
import numpy as np

import sklearn
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis

## Exo 1 - les iris de Fisher
# importation de la base de données
iris = datasets.load_iris()
iris_df = pd.DataFrame(iris.data, columns=iris.feature_names)
iris_df.head()
iris_df.describe()

# base d'apprentissage et base de test
X_train, X_test, y_train, y_test = train_test_split(iris.data, iris.target, train_size=0.50)

# analyse factorielle discriminante
iris.lda = LinearDiscriminantAnalysis().fit(X_train,y_train)
test_pred = iris.lda.predict(X_test)

# matrice de confusion
mc = sklearn.metrics.confusion_matrix(y_test,test_pred)
# taux de bien classés et de mal classés
txbc = np.sum(np.diag(mc))/np.sum(mc)
txmc = 1 - txbc


## Exo 2 - classification d'insectes
insects = pd.read_table("data/insectes.txt", header=None, names=["x1","x2","x3","x4","x5","x6","group"], index_col=False)
insects.head()
insects.describe()

g_group = insects.groupby('group').mean()
g = insects.mean()

# base d'apprentissage et base de test
X_train, X_test, y_train, y_test = train_test_split(insects[['x1','x2','x3','x4','x5','x6']], insects[['group']],train_size=0.50)

insects.lda = LinearDiscriminantAnalysis().fit(X_train,y_train)
test_pred = insects.lda.predict(X_test)
