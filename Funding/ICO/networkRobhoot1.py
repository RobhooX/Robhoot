import matplotlib.pyplot as plt
import networkx as nx

G = nx.cycle_graph(5)
pos = nx.spring_layout(G, iterations=50)
nx.draw(G, pos, node_color=range(5), node_size=800, cmap=plt.cm.Blues)
plt.show()
