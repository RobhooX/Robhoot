Script Workflow Automated Research Platform
Sensu Renku (SDSC) knowledge graph

SUMMARY==========================================
This is a prototype for a script workflow to automate interactions among data search, parsing, integration, database, cleaning, data complexity reduction, pattern and process inference, validation and visualization. The script is based in two types of packages: backbone and specialized packages. Backbone packages (B) connect intra- and inter-layer algorithms to automatically run the workflow. Specialized (S) packages feedback with backbone packages to run specific tasks: parsing, likelihoods, inference, plotting, visualizing, etc. There are at least five properties automated ARP can provide to science: 
1. Testing science: Helping select the best paths in responding to a question? ARP can provide a distribution of solutions by classifying the topologies of the multilayer networks.
2. Identifying bias and uncertainty in inference.
3. Exploring predictions-explanatory gradients to gain sinergy between predictive and explanatory power.
4. Identifying gaps in patterns not explored consequence of lack of integration within and between disciplines, and
5. Facilitating the 4R in open science: reusability, repeatability, replicability, and reproducibility.
================================================

Layers========================
DATA INTEGRATION: D
COMPLEXITY REDUCTION: C
PATTERN-PROCESS INFERENCE: P
VALIDATION: VA
VISUALIZATION: VI
==============================

EXAMPLE with julia ============================================================
Julia packages:
https://github.com/melian009/Robhoot/blob/master/packages.md

WORKFLOW NETWORK-----------------------------

data.search D S                ------> Retriever.jl
parsing.data D S               ------> Query.jl 
data.to.table D S              ------> MySQL.jl SQLite.jl Clickhouse?
data.julia D S                 ------> DataFrames.jl
table.comp.reduction C B       ------> TensorFlow.jl lm4.jl Clustering.jl OnlineAI.jl LightGBM.jl
pattern.detection P S          ------> TensorFlow.jl DataVoyage.jl DataFitting.jl Mocha.jl DeepQLearning.jl Flux.jl AnomalyDetection.jl
proccess.simulation P S        ------> Simjulia.jl Agents.jl JuliaDynamics.jl Zygote.jl
pat.proc.infer P S             ------> mads.jl temporal.jl GlobalSearchRegression.jl BlackBoxOptim.jl JuMP.jl GeneticAlgorithms.jl NaiveBayes.jl Mamba.jl ABC.jl ApproxBayes.jl DynamicHMC.jl
validation.pat.proc VA S       ------> mads.jl LearningStrategies.jl Mamba.jl ABC.jl Measurements.jl
visualiztion.pattern.process   ------> Makie.jl VegaLite.jl
FIN ===========================================================================

















