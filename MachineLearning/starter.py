# imports
import pandas as pd
import torch
import sklearn
import numpy as np
from sklearn.ensemble import RandomForestClassifier as RF
from sklearn.preprocessing import StandardScaler  
from sklearn.neural_network import MLPClassifier

# ignore warning from sklearn that grad descent has not converged
from warnings import simplefilter
from sklearn.exceptions import ConvergenceWarning
simplefilter("ignore", category=ConvergenceWarning)

# for random rotations
from scipy import stats as stats

# load data
# from https://www.kaggle.com/mkoklu42/pistachio-dataset
# which links to https://www.muratkoklu.com/datasets/
# please find another dataset on UCI or Kaggle
# datasets on Kaggle tend to be more cleaned up and easier to start with.

# note that if the data is a csv, you would change this to pd.read_csv
df=pd.read_excel('Acoustic_Extinguisher_Fire_Dataset/Acoustic_Extinguisher_Fire_Dataset.xlsx')

# rename the categorical string features into integer binary classes
# note that all features in this pistachio dataset are already numerical
# but you may need to clean up the features in other datasets.
#df = df.replace({'FUEL':{'gasoline':0,'thinner':1,'kerosene':2}})
#print(df.columns)
#print(df.dtypes)


#simulated data
mu = torch.tensor([2.0,1.0,0.0])
sigma = torch.eye(3)

xd = torch.distributions.MultivariateNormal(mu,sigma)
XS = xd.sample((1000,))

YS = torch.zeros(1000)
for i,j in enumerate(XS):
    YS[i] = torch.cos(j[0])+torch.sin(j[1])+torch.tan(j[2])


XS = XS.numpy()
YS = YS.numpy()
NS = XS.shape[0]
DS = XS.shape[1]
# shuffle simulated data
perm = np.random.permutation(NS)
XS,YS=XS[perm],YS[perm]



# train/test
split_idx = int(NS/2)
Xtrain_S,Ytrain_S=XS[:split_idx],YS[:split_idx]
Xtest_S,Ytest_S =XS[split_idx:],YS[split_idx:]

# standardize the data
scaler = StandardScaler()  
# Don't cheat - fit only on training data
scaler.fit(Xtrain_S)  
Xtrain_S = scaler.transform(Xtrain_S)  
# apply same transformation to test data
Xtest_S = scaler.transform(Xtest_S)  


# split in (X,y)
y = df['FUEL'].to_numpy()
X = df.drop(columns='FUEL').to_numpy()


N = X.shape[0]
D = X.shape[1]

# shuffle data
perm = np.random.permutation(N)
X,y=X[perm],y[perm]

# train/test
split_idx = int(N/2)
Xtrain,ytrain=X[:split_idx],y[:split_idx]
Xtest,ytest =X[split_idx:],y[split_idx:]

# standardize the data
scaler = StandardScaler()  
# Don't cheat - fit only on training data
scaler.fit(Xtrain)  
Xtrain = scaler.transform(Xtrain)  
# apply same transformation to test data
Xtest = scaler.transform(Xtest)  


# random forest and simple feed forward neural network
rf = RF(n_estimators=50,max_depth=5)
nn = MLPClassifier(solver='lbfgs', alpha=1e-5,hidden_layer_sizes=(16,16), random_state=1)

models = {}
models['rf']=rf
models['nn']=nn


for k in models:
    print("model is",k)
    models[k].fit(Xtrain,ytrain)
    print("Train acc",models[k].score(Xtrain,ytrain))
    print("Test acc",models[k].score(Xtest,ytest))
    #models[k].fit(Xtrain_S,Ytrain_S)
    #print("Train acc simulation",models[k].score(Xtrain_S,Ytrain_S))
    #print("Test acc simulation",models[k].score(Xtest_S,Ytest_S))

# example of how to rotate 
A = stats.special_ortho_group.rvs(D)
X_train_rotated = (A @ Xtrain.T).T

for k in models:
    print("rotated model is",k)
    models[k].fit(X_train_rotated,ytrain)
    print("Rotated train acc",models[k].score(X_train_rotated,ytrain))
    print("Rotated test acc",models[k].score(Xtest,ytest))

X_train_transform = np.tanh(X_train_rotated)

for k in models:
    print("transformed model is",k)
    models[k].fit(X_train_transform,ytrain)
    print("Transformed train acc",models[k].score(X_train_rotated,ytrain))
    print("Transformed test acc",models[k].score(Xtest,ytest))


X_train_rtr = (A @ X_train_transform.T).T

for k in models:
    print("rtr model is",k)
    models[k].fit(X_train_rtr,ytrain)
    print("RTR train acc",models[k].score(X_train_rtr,ytrain))
    print("RTR test acc",models[k].score(Xtest,ytest))
