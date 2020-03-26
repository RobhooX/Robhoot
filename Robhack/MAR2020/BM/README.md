   # ROBHOOT :: BAYESIAN SPACE MODELS

Bayesian Models (Julia scripts) :: Hybrid :: PRAGMATIC-ROBHOOT

## KEY REFERENCES BAYESIAN FRAMEWORK

Agent Based and/or stochastic Models

Individual-based modelling of population growth and diffusion in discrete time 
https://doi.org/10.1371/journal.pone.0176101

Stochastic amplification in epidemics
https://doi.org/10.1098/rsif.2006.0192


## MODELING STRATEGY

* [ROBHOOT] :: Multinomial sampling :: Deterministic SIR :: IBM :: ABM 

* Build Modeling strategy knowledge graph
* Mixed or hybrid modeling :: Nodes state dp of the input data


* [PRAGMATIC] :: 3 scenarios

_____________________________________

* Differentiable programming
* Deep Learning Network --> Zygote.jl
_____________________________________


* SIR --> 
  * Spatial network given the data :: city or nation dp resolution 
  * Bayesian fitting ::
 
    mobility : 
    migration :
    infection : 
    transmission :
    recovery = 1 - death :

    5 parameters

* eSIR --> (Enviromental state) --> SIR to SIS 
  * Niche suitability :: 1 parameters

* eSIRevo 
  * Eco-evo dynamics (virulence rate, mutation rate): 2 parameters 
    Random number -->  mutation and virulence rate --> Proxy as recovery rate --> virulence by matching

__________________________________________________________________________________
## QUESTIONS 
* Eco-evo dynamics of hot- and cold- urban spots in the human-Covid-19 interaction
__________________________________________________________________________________


_______________________________________________________________________
## DATA
### PRAGMATIC List of data :: Global environmental, genomic, density, urban, and demography data

* [Genomic](https://www.gisaid.org/epiflu-applications/next-hcov-19-app/) :: https://github.com/nextstrain/ncov Link to data: http://data.nextstrain.org/ncov.json  
* [Demography](https://covid2019-api.herokuapp.com/v2/current) 
* [Environmental](https://envidatrepo.wsl.ch/uploads/chelsa/):: https://github.com/EnviDat/envidat_frontend :: https://github.com/EnviDat/ckan :: https://github.com/EnviDat/ckan 
* [Urban](https://millionneighborhoods.org/#2.45/25.19/23.79)
* [Density](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-density-rev11)

### Parameters
* [Genomic]: time-dependent DNA sequence, mutation rate by geographic location
* [Demography]: time-dependent infected, recovered, deadth (Nation level :: City?)
* [Urban]: City size, aggregation, spatial structure
* [Density]: Population density city level 
* [Environmental]: time-dependent temperature, precipitation at high-resolution (2x2km?)


### ROBHOOT :: 
* Automated API and TABLE import (Check README.md DI)
* AI sampling for the Bayesian framework https://github.com/FluxML/Flux.jl
_____________________________________________________________________

__________________________________________________________________________________________________________________________________
## MODELING
## Hierarchical ABM :: Julia Agents.jl or EvoDynamics.jl :

* https://github.com/JuliaDynamics/Agents.jl
* https://github.com/kavir1698/EvoDynamics.jl

* Bayesian Scientist:: Machine scientist -- code in python at https://bitbucket.org/rguimera/machine-scientist  

* SIR :: Agent-based, single trait, spatially explicit, evolving interaction trait: virus much higher than humans, age-structured,  
* Time-dependent state variables: interaction trait (matching process), susceptibles, infected, recovered
__________________________________________________________________________________________________________________________________


## Priors 

* RATES: 

[Covariance matrix]: High-dimensional parameter space

[Demography]: Mobility -- local, regional, global -- Transmision (interaction trait) :: Recovery :: Deaths :: (4)
[Environmental]: Niche width (1)
[Genomics]: Mutation rate :: Migration rate (connected to Mobility using the covariance matrix) (2) 
[Urban]: city size
[Density]: density or aggregation metrics :: 


### only in a Bayesina setting
### might considere the option of having also frequantist methods

## Posteriors 

### based on the model structure and the potentially available data,
### several inference methods/applicati0n strategies, can be used to fit the mo0del(s) to the data.
### Here a (not comprehensive) List

## OBTAIN joint posterior distribution

### Simpler MCMC Methods and extensions
### Gibbs Sampling (eg in JAGS)
### particle filters (eg POMP package in R)
### Approximate Bayesian computation (ABC)
### Hamiltonian Montecarlo (eg in STAN)
### Multidimensional Pareto Optimization

