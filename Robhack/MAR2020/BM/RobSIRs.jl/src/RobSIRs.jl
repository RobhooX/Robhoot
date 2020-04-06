module RobSIRs

using Distributions
using Agents
using LinearAlgebra: diagind
using StatsBase: weights
using DelimitedFiles
using Dates
using DataFrames

include("model.jl")
include("loadparams.jl")

end  # module