import torch
import matplotlib as pplot
import matplotlib.pyplot as plt
import numpy as np


def regression(c,wtrue,D,t):
	T = torch.zeros([2,t])
	N = 50
	sigma2 = 1
	mu = torch.zeros(D)
	sigma = torch.eye(D)
	for i in range(D):
			for j in range(D):
				if i != j:
					sigma[i,j] = c

	dist = torch.distributions.MultivariateNormal(mu,sigma)
	ndist = torch.distributions.Normal(0,1)

	for i in range(t):
		x = dist.sample(torch.tensor([N]))
		x1 = x[:,0]
		y = x[:,0]*wtrue + ndist.sample(torch.tensor([N]))

		wall = torch.matmul(torch.matmul(torch.inverse(torch.matmul(torch.transpose(x,0,1),x)),torch.transpose(x,0,1)),y)
		w1 = torch.matmul((1/torch.matmul(x1,x1))*x1,y)

		T[0,i] = wall[0]
		T[1,i] = w1

	return T




wtrue = torch.randn(1)
print(wtrue)


c_list = torch.tensor([0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9])
d_list = torch.tensor([2,4,8,16,32])


for d in range(5):
	means = torch.zeros(2,9)
	stds = torch.zeros(2,9)
	for c in range(9):
		test = regression(c_list[c],wtrue,d_list[d],100)
		mean = test.mean(1)
		stddev = test.std(1)
		means[0,c] = mean[0]
		means[1,c] = mean[1]
		stds[0,c] = stddev[0]
		stds[1,c] = stddev[1]

	stats = plt.figure()
	plt.plot(c_list, means[0,:], label = "w_all")
	plt.plot(c_list,means[1,:],label = "w_1")
	plt.axhline(y = np.array(wtrue), color = "C3", label = "w_true")
	stats.suptitle("Means for {} dimensions".format(d_list[d]))
	plt.xlabel("c_value (covariance)")
	plt.ylabel("w_value (weight)")
	plt.legend()
	plt.show()


	stats = plt.figure()
	plt.plot(c_list, stds[0,:], label = "w_all")
	plt.plot(c_list,stds[1,:],label = "w_1")
	stats.suptitle("Standard devs for {} dimensions".format(d_list[d]))
	plt.xlabel("c_value (covariance)")
	plt.ylabel("Standard Deviation")
	plt.legend()
	plt.show()

