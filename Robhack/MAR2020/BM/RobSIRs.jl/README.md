# RobSIRs

A stochastic discrete time model of disease spread.

## Equations per node

* $$S[t]i = S[t-1]i - b(c)\times S[t-1]i \times I[t-1]i - m\times S[t-1]ji + m\times S[t-1]ij + s\times R[t-1]i - ds\timesS[t-1]i$$
* $$I[t]i = I[t-1]i + b(c)\times S[t-1]i \times I[t-1]i - a\times I[t-1]i - m\times I[t-1]ji + m\times I[t-1]ij - dI\timesI[t-1]i$$
* $R[t]i = R[t-1]i + a\times I[t-1]i - m\times I[t-1]ji + m\times I[t-1]ij - s\times R[t-1]i - dr\times R[t-1]i$

### Parameters

* b: susceptible to infectious transmission rate  
* c: susceptible to infectious contact rate
* m: migration to/from j rate
* s: recovered to susceptible rate
* a: infected to recovered rate
* d: death rate (ds, dI, dr)
