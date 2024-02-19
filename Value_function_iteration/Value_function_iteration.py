#%%
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import sys

#%% directory
os.chdir('/Users/samueleborsini/File/Python')

#%% economic parametert
b=4/5
a=0.3
A=1

# utility function
def u(c):
    return np.sqrt(c)

# production function
def f(k):
    return k

# grid
k = pd.Series(np.linspace(0.1, 10, 10000))

# value function iteration parameters
tol = 1e-6
max_iter = 1000

#%% Numerical procedure
V = np.zeros(len(k))

diff = tol + 1
j=0

while (diff > tol) and (j < max_iter):
    V_new = np.zeros(len(k))
    k_pol = np.zeros(len(k))
    for i in range(len(k)):
        k_feasible = k[k<=f(k[i])]
        k_pol[i] = np.argmax(u(f(k[i])-k_feasible) + b*V[i])
        V_new[i] = np.max(u(f(k[i])-k_feasible) + b*V[i])
    diff = np.max(np.abs(V_new - V))
    V = V_new
    j += 1
    print(j)

# %% plot the value function
# make it a line plot
plt.plot(k,V)
plt.xlabel('Capital')
plt.ylabel('Value function')
plt.show()

# %%
V_t=(5/3)*np.sqrt(k)
plt.plot(k,V_t)
plt.xlabel('Capital')
plt.ylabel('Value function')
plt.show()

