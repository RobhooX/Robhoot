#__________________________________________________
#___________________________________________________

# Stochastic SIR to infer the parameters:
  #b: susceptible to infectious transmission rate  
  #c: susceptible to infectious contact rate
  #m: migration to/from j rate
  #s: recovered to susceptible rate
  #a: infected to recovered rate
  #d: death rate (ds, dI, dr)

# ...that best predict S, I, R and D from
# Global Density (S), Infected (I) and Deaths (D)
# Global Mobility 
  # Isolated
  # Fully connected, 
  # Empirical mobility rate)
#___________________________________________________
#____________________________________________________

module RobSIRs.jl

using Distributions

end  # module