import pandas as pd
import torch
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
sns.set_style('whitegrid')


N = 1000
poi = torch.distributions.Poisson(torch.tensor([3.0]))
ber = torch.distributions.Bernoulli(torch.tensor([0.7]))

p = poi.sample((N,))
b = ber.sample((N,))


p = p.numpy()
b = b.numpy()

pb = np.multiply(p,b)

plt.hist(p)
plt.show()

plt.hist(pb)
plt.show()