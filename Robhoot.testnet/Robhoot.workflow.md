___________________________________________________________________________________________________
# ROBHOOT 

## TESTNET AS A DECENTRALIZED AUTOMATED RESEARCH NETWORK (DARENET)

## GOAL

* FUNCTIONAL SCRIPT WORKFLOW INTEGRATING LANGUAGES (PYTHON, JULIA, NATURAL LAUNGUAGE, ...)

Prototyping a script workflow to automate the layers in Robhoot:
from data adquisition and integration to validation and visualization. 
The script is based in two types of packages: backbone and specialized packages. 
Backbone packages (B) connect intra- and inter-layer algorithms to automatically run the workflow. 
Specialized (S) packages feedback with backbone packages to run specific tasks: 
parsing, likelihoods, inference, plotting, visualizing, etc. 

## There are at least five properties of DARENET Software (Decentralized automated research network) can provide to science:

* Science of science: Inferring the best paths in responding to questions by providing distributions of solutions 
   by classifying the topologies of multilayer networks.
* Identifying bias and uncertainty in inference.
* Exploring predictions-explanatory gradients to gain sinergy between predictive and explanatory power.
* Identifying gaps in patterns not explored consequence of lack of integration within and between disciplines, and
* Facilitating the 4R in open science: reusability, repeatability, replicability, and reproducibility.


# NOTATION for the Julia example below

## DATA INTEGRATION (D)

## COMPLEXITY REDUCTION (C)

## PATTERN-PROCESS INFERENCE (P)

## VALIDATION (VA) 

## VISUALIZATION (VI)

## Backbone packages (B)

## Specialized packages (S)
________________________________________________________________________________________________


____________________________________________________________________________________________
# DATA INTEGRATION :: UNIVERSAL AUTOMATED ETLs ALGORITHM


## Universal Automated ETLs Algorithm

## GOALS

### Flexibility
### Robustness
### Integrtaion capabilities
### Multiple language recognition
### Minimize human-inputs

### Languages :: Python, Julia other
### Features :: 
	* Programmed to understand Schema Webmasters and to connect to (Open) search engines
	* Detect links-webs with given words-questions
	* Make a list of links-webs and ask questions :: Open-close, API, access properties, ...
	* Building temporal DB :: accounting for missing values, etc
	* Extracting to the temporal DB
	* Transforming the extrcted data to standard DB
	* Loading the standard DB for :: cleaning, complexity reduction analysis, initial plotting and visualization


### Julia packages (with Python integration):
* [packagesJulia](https://github.com/melian009/Robhoot/Robhoot.testnet/packagesJulia.md)

* data.search D S           ------> Retriever.jl
* parsing.data D S          ------> Query.jl 
* data.to.table D S         ------> MySQL.jl SQLite.jl Clickhouse?
* data.julia D S            ------> DataFrames.jl
* table.comp.reduction C B  ------> TensorFlow.jl lm4.jl Clustering.jl OnlineAI.jl LightGBM.jl

### Build Knowledge Graph (KG) using Renku
____________________________________________________________________________________________


______________________________________________________________________________________________________________
# INFERENCE :: AUTOMATED SEARCHING OVER LARGE SPACE OF (ORTHOGONAL) MODELS


## Automated searching large space of (orthogonal) models

## GOALS
* Orthogonal models : models with non correlated assumptions, features and predictions
* Open-ended model exploration
* Broad set of language of models 


### Julia packages (with Python integration):
* [packagesJulia](https://github.com/melian009/Robhoot/Robhoot.testnet/packagesJulia.md)

* pattern.detection P S     ------> TensorFlow.jl DataVoyage.jl DataFitting.jl Mocha.jl DeepQLearning.jl Flux.jl 
AnomalyDetection.jl
* proccess.simulation P S   ------> Simjulia.jl Agents.jl JuliaDynamics.jl Zygote.jl
* pat.proc.infer P S        ------> mads.jl temporal.jl GlobalSearchRegression.jl BlackBoxOptim.jl 
JuMP.jl GeneticAlgorithms.jl NaiveBayes.jl Mamba.jl ABC.jl ApproxBayes.jl DynamicHM.jl
* validation.pat.proc VA S  ------> mads.jl LearningStrategies.jl Mamba.jl ABC.jl Measurements.jl
______________________________________________________________________________________________________________


_____________________________________________________________________________________
# COMMUNICATION :: FEEDBACK, VISUALIZATION, REPORTING, AND BROADCASTING USER/DEVELOPER

## Automated communication, feedback, reporting and broadcasting with user/developer

## GOALS

### Feedback with user-developer
### Searching broad plotting space over orthogonal methods
### Converting fitting, results and methods to natural language (plain English)


# BROADCAST 

### EXAMPLE TELEGRAM ------------------------------------ 

### Robhoot --> RobhooX --> VISION --> Broadcast Telegram Open network fully automated report

### STEP 1

### Forum
* [yourfirstbot](https://www.freecodecamp.org/news/learn-to-build-your-first-bot-in-telegram-with-python-4c99526765e4/)
* [gist](https://gist.github.com/lucaspg96/284c9dbe01d05d0563fde8fbb00db220)
* [sendmessage](https://medium.com/@ManHay_Hong/how-to-create-a-telegram-bot-and-send-messages-with-python-4cf314d9fa3e)
* [stable](https://python-telegram-bot.readthedocs.io/en/stable/)
* [python-telegram](https://python-telegram-bot.org/)

### STEP 2 

### Forum
* [wiki](https://github.com/python-telegram-bot/python-telegram-bot/wiki/Extensions-%E2%80%93-Your-first-Bot)
* [Starting conversation telegram python bot](https://www.codementor.io/@garethdwyer/building-a-telegram-bot-using-python-part-1-goi5fncay)

* First create :: Robhoot
* Group : RobhooX --> added Ali Charles Victor 
* https://telegram.me/Robhbot
* https://api.telegram.org/bot1065718228:AAEzGbD-0-Nj5U7q1AHiZ-R9HzSJaIOHnZ4/getme
* https://api.telegram.org/bot1065718228:AAEzGbD-0-Nj5U7q1AHiZ-R9HzSJaIOHnZ4/getUpdates
* https://api.telegram.org/bot1065718228:AAEzGbD-0-Nj5U7q1AHiZ-R9HzSJaIOHnZ4/sendMessage?chat_id=319178712&text=TestReply
* RobhooX broadcast :: run python echobot1.py

### Julia packages (with Python integration):
* [packagesJulia](https://github.com/melian009/Robhoot/Robhoot.testnet/packagesJulia.md)

* visualiztion.pattern.process ------> Makie.jl VegaLite.jl
______________________________________________________________________________________
                    
                                     === FIN ===
