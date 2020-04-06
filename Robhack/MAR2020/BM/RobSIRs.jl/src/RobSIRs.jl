module RobSIRs

using Agents
using Distributions
using Agents
using LinearAlgebra: diagind
using StatsBase: weights
using DelimitedFiles
using Dates
using DataFrames
using LightGraphs

include("model.jl")
include("loadparams.jl")

end  # module