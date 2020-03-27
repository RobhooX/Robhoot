# RobSIRs

A stochastic discrete time model of disease spread in spatial networks.

## VISION

Modeling mobility dynamics (NODE: country or city level) at the global scale
to infer S, I, R and D types per NODE from Global Density (S), Infected (I) and Deaths (D) for Isolated, Fully connected, and Empirical mobility rate estimations. 

## SIR equations per NODE

* $S_{[t]_i} = S_{[t-1]_i} - b(c)\times S_{[t-1]_i} \times I_{[t-1]_i} - m\times S_{[t-1]_{ji}} + m\times S_{[t-1]_{ij}} + s\times R_{[t-1]_i} - ds\times S_{[t-1]_i}$

* $I_{[t]_i} = I_{[t-1]_i} + b(c)\times S_{[t-1]_i} \times I_{[t-1]_i} - a\times I_{[t-1]_i} - m\times I_{[t-1]_{ji}} + m\times I_{[t-1]_{ij}} - dI\times I_{[t-1]_{i}}$

* $R[t]_i = R[t-1]_i + a\times I[t-1]_i - m\times I[t-1]_{ji} + m\times I[t-1]_{ij} - s\times R[t-1]_{i} - dr\times R[t-1]_i$

### Parameters

* b: susceptible to infectious transmission rate  
* c: susceptible to infectious contact rate
* m: migration to/from j rate
* s: recovered to susceptible rate
* a: infected to recovered rate
* d: death rate (ds, dI, dr)

## Generalization of the equations for an automated simulator builder 

* Process-based knowledge graph to explore populations of models. For example, the SIR equations per NODE described above can be generalized to have Sn nodes for susceptibles (i.e., age classes), In nodes for infected, and Rn nodes for recoverd. In addition, there might be other node types, like explosed, unreported and reported infectious and hospitalized.