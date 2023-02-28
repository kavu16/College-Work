import torch
import matplotlib as pplot
import matplotlib.pyplot as plt
import numpy as np

wtrue = torch.tensor([1.0])
sigmasq = torch.tensor([1.0])

N = np.array([10,100,1000,10000])

nx = torch.distributions.Normal(0,1.0)
n0 = torch.distributions.Normal(0,1.0)

means = torch.zeros([3,4])


for i in range(4):
	x1 = nx.sample(torch.tensor([N[i],1]))
	x1t = torch.transpose(x1,0,1)
	x2 = torch.cat((x1,x1.pow(2)),1)
	x2t = torch.transpose(x2,0,1)
	y = wtrue*(x1.pow(2)) + n0.sample(torch.tensor([N[i],1]))

	sigma = torch.inverse(torch.eye(1) + sigmasq*torch.matmul(x1t,x1))
	sigma2 = torch.inverse(torch.eye(2) + sigmasq*torch.matmul(x2t,x2))
	mu = sigma*sigmasq*torch.matmul(x1t,y)
	mu2 = torch.matmul(sigma2,sigmasq*torch.matmul(x2t,y))

	means[0,i] = mu 
	means[1,i] = mu2[0]
	means[2,i] = mu2[1]

	print(sigma)
	print(sigma2)

print(means)

