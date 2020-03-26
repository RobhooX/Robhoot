include("RobSIR.jl")

function cost(C, max_travel_rate)
  params = create_params(C=C, max_travel_rate=max_travel_rate)
  model = model_initiation(;params...)
  data_to_collect = Dict(:status => [infected, recovered, length])
  data = step!(model, agent_step!, 10, data_to_collect)
  #step!(model, agent_step!, model_step!, 1)
  sum(data[!, Symbol("infected(status)")])
#return data
end


#df=cost(5, 0.01)
#A = convert(Array, df)

using Zygote

<<<<<<< HEAD
#Examples
#gradient(x -> 3x^2 + 2x + 1, 5)
#gradient(x -> pow2(x, 3), 5)
#https://github.com/FluxML/Zygote.jl/issues/295


gradient((C, max_travel_rate) -> cost(C, max_travel_rate), 5, 0.01)
#gradient((C, max_travel_rate) -> A[C, max_travel_rate], 5, 3)
#gradient((C, max_travel_rate) -> max_travel_rate + C, 5, 0.01)


=======
gradient((C, max_travel_rate) -> cost(C, max_travel_rate), 5, 0.01)
>>>>>>> 1efbdb9b68b69bc68eb8fae54e482f4cda1b2175
