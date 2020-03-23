# Data Integration

## ARCHITECTURE (DATA GATHERING)

* Data comes from many protocols, formats and spatio-temporal resolution. 
* Run each node with a database. 
* Explore the database gradient: Highly heterogeneous to homogeneous data
* Record metadata with each data set. 
* One option is to merge all the data with an effort from identifying different labels with the same tag (semantics, e.g., county vs municipality, city,...), or different protocols to generate the data... and then perform the analysis.
* Another option is to keep the data as it comes from the source and perform the analysis on each source and the merge the results. 

### TO DECIDE 
 
* One or more language
* Julia script to Golem network

### DETLs : DISCOVER, EXTRACT, TRANSFORM AND LOAD 

## Discover

* Create Question-based knowledge graph from existing literature (corpus conversion algorithms)
* Automated generation of a knowledge graphs given a few keywords of a given topic :: connecting servers by similarity
* Make server list with case study data
* Create list web data for COVID-19 
    * [Fluentd](https://docs.fluentd.org/installation/install-by-deb)
    * NLP (Natural Language Processing) algorithms.
    * [Hadoop](https://github.com/melian009/Robhoot/issues/1)
    * [BigchainDB](https://www.bigchaindb.com/) -- check also [here](https://gnunet.org/en/index.html).

## Extract

Download data-protocols from many formats :: `download.py` and download.jl 

## Transform

Transform data (keep protocols) from many formats 

### Central data storage format

xml csv (h5 (not read in C)) :: general format extracted and transformed from many data types and protocols

#### SQL

##### Pros

* Table format. Easy for data analysis
* Fast to search and retrieve data.
* Easy to merge many tables.
* Programming-language agnostic.

##### Cons

* Only table format.

#### Clickhouse

##### Pros

##### Cons


## Load

### Load to Julia Python 







