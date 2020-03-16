#https://stackoverflow.com/questions/45257058/algorithm-to-prune-nodes-in-network-achieve-maximum-number-of-isolates-python
import networkx as nx
import matplotlib.pyplot as plt

G = nx.DiGraph()
G.add_edges_from([(1,2), (2,3), (2,4), (3,5), (3,6), (4,7), (4,8),
 (1,2+9), (2+9,3+9), (2+9,4+9), (3+9,5+9), (3+9,6+9), (4+9,7+9), (4+9,8+9) ])


#G = nx.cycle_graph(5)
pos = nx.spring_layout(G, iterations=50)
nx.draw(G, pos, node_size=800, cmap=plt.cm.Blues)
plt.show()
