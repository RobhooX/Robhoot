#https://stackoverflow.com/questions/35392342/how-to-change-colours-of-nodes-and-edges-of-bipartite-graph-in-networkx

import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
from networkx.algorithms import bipartite
import scipy.sparse as sparse

a_matrix = sparse.rand(5, 10, format='coo', density=0.8)

G = bipartite.from_biadjacency_matrix(a_matrix, create_using=None,edge_attribute='weight')
X, Y = bipartite.sets(G)
pos = dict()
pos.update((n, (-1, i*11)) for i, n in enumerate(X))
pos.update((n, (0.5, i*5)) for i, n in enumerate(Y))
num_edges = G.number_of_edges()
num_nodes = G.number_of_nodes()
#nx.draw(G, pos=pos, with_labels=True,edge_color=np.random.random(num_edges), edge_cmap=plt.get_cmap('Blues'), node_color=np.random.random(num_nodes), cmap=plt.get_cmap('Reds'))
nx.draw(G, pos=pos, with_labels=True,edge_color=np.random.random(num_edges), edge_cmap=plt.get_cmap('Reds'), node_color=range(num_nodes), node_size=1400, cmap=plt.cm.Reds)




#C = nx.connected_component_subgraphs(G)
#for g in C:
#    node_colors = [random.random()] * nx.number_of_nodes(g)
#    nx.draw(g, pos, node_size=40, node_color=node_colors, vmin=0.0, vmax=1.0, with_labels=False 

b_matrix = sparse.rand(10, 10, format='coo', density=0.8)
G = bipartite.from_biadjacency_matrix(b_matrix, create_using=None,edge_attribute='weight')
Y, Z = bipartite.sets(G)
pos = dict()
pos.update((n, (0.5, i*5)) for i, n in enumerate(Y))
pos.update((n, (2, i*5)) for i, n in enumerate(Z))
num_edges = G.number_of_edges()
num_nodes = G.number_of_nodes()
#nx.draw(G, pos=pos, with_labels=True,edge_color=np.random.random(num_edges), edge_cmap=plt.get_cmap('Blues'), node_color=np.random.random(num_nodes), cmap=plt.get_cmap('Reds'))
nx.draw(G, pos=pos, with_labels=False,edge_color=np.random.random(num_edges), edge_cmap=plt.get_cmap('Blues'), node_color=range(num_nodes), node_size=800, cmap=plt.cm.Blues)

plt.show()



