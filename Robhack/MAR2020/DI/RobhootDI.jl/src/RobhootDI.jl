module RobhootDI

using RemoteFiles
using HTTP
using JSON3
using DataFrames
using Dates
using DrWatson
@quickactivate

include("discover.jl")
include("extract.jl")
include("transform.jl")

end # module