# Julia packages for Robhoot

## Data acquisition and retrieval

* [Retriever](https://github.com/weecology/Retriever.jl): Data Retriever automates the tasks of finding, downloading, and cleaning up publicly available data, and then stores them in a local database or as .csv files. NB: not updated

### Data query

* [Query](https://github.com/queryverse/Query.jl): Query is a package for querying julia data sources. It can filter, project, join and group data from any iterable data source, including all the sources supported in IterableTables.jl. 

### Databases 

* [SQLite](https://github.com/JuliaDatabases/SQLite.jl)
* [MySQL](https://github.com/JuliaDatabases/MySQL.jl)
* [Lightning Memory-Mapped Database (LMDB)](https://github.com/wildart/LMDB.jl)
* [MongoDB](https://github.com/ScottPJones/Mongo.jl)
* [CQLDriver](https://github.com/r3tex/CQLdriver.jl): This Julia package is an interface to ScyllaDB / Cassandra and is based on the Datastax CPP driver implementing the CQL v3 binary protocol. NB: not updated

### Data types

* [ShiftedArrays](https://github.com/piever/ShiftedArrays.jl): A ShiftedArray is a lazy view of an Array, shifted on some or all of his indexing dimensions by some constant values.
* [MPIArrays](https://github.com/barche/MPIArrays.jl): This package provides distributed arrays based on MPI one-sided communication primitives. It is currently a proof-of-concept.
* [Schemata](https://github.com/JockLawrie/Schemata.jl): A Schema is a specification of a data set. It exists independently of any particular data set, and therefore can be constructed and modified in the absence of a data set. This package facilitates 3 use cases:
  * Read/write a schema from/to a yaml file. Thus schemata are portable, and a change to a schema does not require recompilation.
  * Compare a data set to a schema and list the non-compliance issues.
  * Transform an existing data set in order to comply with a schema as much as possible (then rerun the compare function to see any outstanding issues).
* [Ratios](https://github.com/timholy/Ratios.jl): Faster Rational-like types for Julia.
* [Scalar](https://github.com/sabjohnso/Scalar.jl): Scalar Types.
* [DataFrames](https://github.com/JuliaData/DataFrames.jl): Library for working with tabular data in Julia.

#### Time series

* [Temporal](https://github.com/dysonance/Temporal.jl): Time series implementation for the Julia language focused on efficiency and flexibility. 
* [GlobalSearchRegression](https://github.com/ParallelGSReg/GlobalSearchRegression.jl): Automatic model selection command for time series, cross-section and panel data regressions.

### Storage formats

* [RawArray](https://github.com/davidssmith/RawArray.jl): RawArray (RA) is a simple file format for storing n-dimensional arrays.
* [ASDF](https://github.com/eschnett/ASDF.jl): The Advanced Scientific Data Format (ASDF) is a file format for scientific data. It is based on the human-readable YAML standard, extended with efficient binary blocks to store array data. 
* [HDF5](https://github.com/JuliaIO/HDF5.jl): Saving and loading data in the HDF5 file format.
* [Taro](https://github.com/aviks/Taro.jl): Read and write Excel, Word and PDF documents in Julia.
* [LazyJSON](https://github.com/samoconnor/LazyJSON.jl): LazyJSON is an interface for reading JSON data in Julia programs.
* [JSON2](https://github.com/quinnj/JSON2.jl): Fast json marshalling/unmarshalling with Julia types.

### Web access

* [HTTP](https://github.com/JuliaWeb/HTTP.jl)

### Data exploration

* [DataVoyage](https://github.com/queryverse/DataVoyager.jl): Voyager 2 is a data exploration tool that blends manual and automated chart specification.

## Pattern inference

* [Mads](https://github.com/madsjulia/Mads.jl): MADS is an integrated open-source high-performance computational (HPC) framework in Julia. MADS can execute a wide range of data- and model-based analyses: 
  * Sensitivity Analysis
  * Parameter Estimation
  * Model Inversion and Calibration
  * Uncertainty Quantification
  * Model Selection and Model Averaging
  * Model Reduction and Surrogate Modeling
  * Machine Learning and Blind Source Separation
  * Decision Analysis and Support

  MADS has been tested to perform HPC simulations on a wide-range multi-processor clusters and parallel environments (Moab, Slurm, etc.). MADS utilizes adaptive rules and techniques which allows the analyses to be performed with a minimum user input. The code provides a series of alternative algorithms to execute each type of data- and model-based analyses.
* [LearningStrategies](https://github.com/JuliaML/LearningStrategies.jl): A generic and modular framework for building custom iterative algorithms in Julia.

### Data fitting

* [DataFitting](https://github.com/gcalderone/DataFitting.jl)
* [LsqFit](https://github.com/JuliaNLSolvers/LsqFit.jl): Simple curve fitting in Julia
* [GaussianProcesses](https://github.com/STOR-i/GaussianProcesses.jl): This package allows the user to fit exact Gaussian process models when the observations are Gaussian distributed about the latent function. In the case where the observations are non-Gaussian, the posterior distribution of the latent function is intractable. The package allows for Monte Carlo sampling from the posterior.

### Optimization

* [BlackboxOptim](https://github.com/robertfeldt/BlackBoxOptim.jl): BlackBoxOptim is a global optimization package for Julia. It supports both multi- and single-objective optimization problems and is focused on (meta-)heuristic/stochastic algorithms (DE, NES etc) that do NOT require the function being optimized to be differentiable.
* [NODAL](https://github.com/phrb/NODAL.jl): NODAL provides tools for implementing parallel and distributed program autotuners. This Julia package provides tools and optimization algorithms for implementing different Stochastic Local Search methods, such as Simulated Annealing and Tabu Search. NODAL is an ongoing project, and will implement more optimization and local search algorithms.
* [JuMP](https://github.com/JuliaOpt/JuMP.jl): Modeling language for Mathematical Optimization (linear, mixed-integer, conic, semidefinite, nonlinear).
* [Convex](https://github.com/JuliaOpt/Convex.jl): a Julia package for Disciplined Convex Programming. Convex.jl can solve linear programs, mixed-integer linear programs, and DCP-compliant convex programs using a variety of solvers, including Mosek, Gurobi, ECOS, SCS, and GLPK, through the MathProgBase interface. It also supports optimization with complex variables and coefficients.
* [Optim](https://github.com/JuliaNLSolvers/Optim.jl): Univariate and multivariate optimization in Julia.
* [GeneticAlgorithms](https://github.com/WestleyArgentum/GeneticAlgorithms.jl): A lightweight framework for writing genetic algorithms in Julia.

### Distribution inference

* [MixtureModels](https://github.com/lindahua/MixtureModels.jl): A mixture model is a probabilistic model that combines multiple components to capture data distribution.
* [GaussianMixtures](https://github.com/davidavdav/GaussianMixtures.jl): This package contains support for Gaussian Mixture Models. Basic training, likelihood calculation, model adaptation, and i/o are implemented. This Julia type is more specific than Dahua Lin's MixtureModels, in that it deals only with normal (multivariate) distributions (a.k.a Gaussians), but it does so more efficiently.

### Machine learning

* [LightGBM](https://github.com/Allardvm/LightGBM.jl): A fast, distributed, high performance gradient boosting (GBDT, GBRT, GBM or MART) framework based on decision tree algorithms, used for ranking, classification and many other machine learning tasks.
* [ScikitLearn](https://github.com/cstjean/ScikitLearn.jl)
* [Clustering](https://github.com/JuliaStats/Clustering.jl): A Julia package for data clustering.
* [MLDatasets](https://github.com/JuliaML/MLDatasets.jl): Utility package for accessing common Machine Learning datasets in Julia.
* [OnlineAI](https://github.com/tbreloff/OnlineAI.jl): Machine learning for sequential/streaming data.

#### Auto-ML

* [auto-sklearn](https://github.com/automl/auto-sklearn): Automated Machine Learning with scikit-learn. This package is in Python.

### Deep learning

* [Mocha](https://github.com/pluskid/Mocha.jl): Mocha is a Deep Learning framework for Julia, inspired by the C++ framework Caffe.
* [Knet](https://github.com/denizyuret/Knet.jl): the Koç University deep learning framework.
* [Flux](http://fluxml.ai/): Models that look like mathematics. Seamless derivatives, GPU training and deployment. A set of small, nimble tools that each do one thing and do it well. 
* [TensorFlow](https://github.com/malmaud/TensorFlow.jl): a popular open source machine learning framework from Google.
* [MXNet](https://github.com/dmlc/MXNet.jl): brings flexible and efficient GPU computing and state-of-art deep learning to Julia.
* [Merlin](https://github.com/hshindo/Merlin.jl): It aims to provide a fast, flexible and compact deep learning library for machine learning.
* [Strada](https://github.com/pcmoritz/Strada.jl): A deep learning library for Julia based on Caffe.
* [DeepQLearning](https://github.com/Andy-P/DeepQLearning.jl): Julia implementation of DeepMind's Deep Q Learning algorithm described in "Playing Atari with Deep Reinforcement Learning".
* [AnomalyDetection](https://github.com/smidl/AnomalyDetection.jl): Implementation of various generative neural network models for anomaly detection in Julia, using the Flux framework.

### Bayesian inference

* [NaiveBayes](https://github.com/dfdx/NaiveBayes.jl): Naive Bayes classifier.
* [Mamba](https://github.com/brian-j-smith/Mamba.jl): Mamba is an open platform for the implementation and application of MCMC methods to perform Bayesian analysis in julia. The package provides a framework for (1) specification of hierarchical models through stated relationships between data, parameters, and statistical distributions; (2) block-updating of parameters with samplers provided, defined by the user, or available from other packages; (3) execution of sampling schemes; and (4) posterior inference.
* [ABC](https://github.com/eford/ABC.jl): Approximate Bayesian Computing with Julia.
* [ApproximateBayesianComputing](https://github.com/eford/ApproximateBayesianComputing.jl): Currently, it implements a single algorithm, ABC-PMC based on Beaumont et al. 2002 via abc_pmc_plan_type.
* [ApproxBayes](https://github.com/marcjwilliams1/ApproxBayes.jl): Approximate Bayesian Computation (ABC) algorithms for likelihood free inference.

### Markov models

* [HiddenMarkovModels](https://github.com/BenConnault/HiddenMarkovModels.jl): Basic simulation / parameter estimation / latent state inference for hidden Markov models. Thin front-end package built on top of DynamicDiscreteModels.jl.

### Monte Carlo

* [DynamicHMC](https://github.com/tpapp/DynamicHMC.jl): Bare-bones implementation of robust dynamic Hamiltonian Monte Carlo methods.

### Uncertainty estimation

* [Measurements](https://github.com/JuliaPhysics/Measurements.jl): It is a package that allows you to define numbers with uncertainties, perform calculations involving them, and easily get the uncertainty of the result according to linear error propagation theory.

## Validation

### Agent-based modeling frameworks

* [SimJulia](https://github.com/BenLauwens/SimJulia.jl
): A discrete event process oriented simulation framework written in Julia inspired by the Python library SimPy.

## Data Visualization

* [Makie](https://github.com/JuliaPlots/Makie.jl): High level plotting on the GPU 