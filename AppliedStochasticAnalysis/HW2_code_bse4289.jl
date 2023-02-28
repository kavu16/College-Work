using LinearAlgebra
using StatsBase

P = [0.8 0.2; 0.4 0.6]

P^10
P^40
P^100

P = [0.9 0.1 0 0 0; 0.6 0 0.4 0 0; 0 0.6 0 0.4 0; 0 0 0.6 0 0.4; 0 0 0 1 0]

pi = eigvecs(transpose(P))[:,5]
mu = eigvecs(P)[:,5]

P^100

pi = pi/sum(pi)

weights = (P^100)[2,:]
items = [0,1,2,3,4]
x1 = sample(items,weights,50)
x2 = sample(items,weights,50)
x3 = sample(items,weights,50)
x4 = sample(items,weights,50)
x5 = sample(items,weights,50)
