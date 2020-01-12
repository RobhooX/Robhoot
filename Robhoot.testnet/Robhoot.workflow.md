



Foreground : Connecting layers to telegram (or other) bot 
Background : Script Workflow Automated Research Platform -- Sensu Renku (SDSC) knowledge graph


Prototype for a script workflow to automate interactions within and among the five layers contained in Robhoot, from data adquisition and integration to validation and visualization. The script is based in two types of packages: backbone and specialized packages. Backbone packages (B) connect intra- and inter-layer algorithms to automatically run the workflow. Specialized (S) packages feedback with backbone packages to run specific tasks: parsing, likelihoods, inference, plotting, visualizing, etc. There are at least five properties automated ARP can provide to science:

1. Science of science: Inferring the best paths in responding to questions. DARP will provide distributions of solutions by classifying the topologies of multilayer networks.
2. Identifying bias and uncertainty in inference.
3. Exploring predictions-explanatory gradients to gain sinergy between predictive and explanatory power.
4. Identifying gaps in patterns not explored consequence of lack of integration within and between disciplines, and
5. Facilitating the 4R in open science: reusability, repeatability, replicability, and reproducibility.


Notation:
DATA INTEGRATION (D)

COMPLEXITY REDUCTION (C)

PATTERN-PROCESS INFERENCE (P)

VALIDATION (VA) 

VISUALIZATION (VI)

Backbone packages (B)

Specialized packages (S)


Script workflow EXAMPLE with julia

Julia packages:
https://github.com/melian009/Robhoot/blob/master/packages.md

data.search D S           ------> Retriever.jl

parsing.data D S          ------> Query.jl 

data.to.table D S         ------> MySQL.jl SQLite.jl Clickhouse?

data.julia D S            ------> DataFrames.jl

table.comp.reduction C B  ------> TensorFlow.jl lm4.jl Clustering.jl OnlineAI.jl LightGBM.jl

pattern.detection P S     ------> TensorFlow.jl DataVoyage.jl DataFitting.jl Mocha.jl DeepQLearning.jl Flux.jl 
AnomalyDetection.jl

proccess.simulation P S   ------> Simjulia.jl Agents.jl JuliaDynamics.jl Zygote.jl

pat.proc.infer P S        ------> mads.jl temporal.jl GlobalSearchRegression.jl BlackBoxOptim.jl JuMP.jl GeneticAlgorithms.jl NaiveBayes.jl Mamba.jl ABC.jl ApproxBayes.jl DynamicHMC.jl

validation.pat.proc VA S  ------> mads.jl LearningStrategies.jl Mamba.jl ABC.jl Measurements.jl

visualiztion.pattern.process ------> Makie.jl VegaLite.jl
                    
                                     === FIN ===
