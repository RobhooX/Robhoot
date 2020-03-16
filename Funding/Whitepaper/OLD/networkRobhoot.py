#https://zhuanlan.zhihu.com/p/36700425
import matplotlib.pyplot as plt
import networkx as nx 
left, right, bottom, top, layer_sizes = .1, .9, .1, .9, [4, 7, 7, 2]
# 网络离上下左右的距离
# layter_sizes可以自己调整
import random
G = nx.Graph()
v_spacing = (top - bottom)/float(max(layer_sizes))
h_spacing = (right - left)/float(len(layer_sizes) - 1)
node_count = 0
for i, v in enumerate(layer_sizes):
    layer_top = v_spacing*(v-1)/2. + (top + bottom)/2.
    for j in range(v):
        G.add_node(node_count, pos=(left + i*h_spacing, layer_top - j*v_spacing))
        node_count += 1
# 这上面的数字调整我想了好半天，汗
for x, (left_nodes, right_nodes) in enumerate(zip(layer_sizes[:-1], layer_sizes[1:])):
    for i in range(left_nodes):
        for j in range(right_nodes):
            G.add_edge(i+sum(layer_sizes[:x]), j+sum(layer_sizes[:x+1]))    
# 慢慢研究吧
pos=nx.get_node_attributes(G,'pos')
# 把每个节点中的位置pos信息导出来
nx.draw(G, pos, 
        node_color=range(node_count), 
        with_labels=True,
        node_size=500, 
        edge_color=[random.random() for i in range(len(G.edges))], 
        width=3, 
        cmap=plt.cm.Dark2, # matplotlib的调色板，可以搜搜，很多颜色呢
        edge_cmap=plt.cm.Blues
       )
plt.show() 
