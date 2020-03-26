include("RobSIR.jl")

function cost(C, max_travel_rate)
  params = create_params(C=C, max_travel_rate=max_travel_rate)
  model = model_initiation(;params...)
  data_to_collect = Dict(:status => [infected, recovered, length])
  data = step!(model, agent_step!, 10, data_to_collect)
  sum(data[!, Symbol("infected(status)")])
end

cost(5, 0.01)

using Zygote

gradient((C, max_travel_rate) -> cost(C, max_travel_rate), 5, 0.01)
