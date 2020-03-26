<<<<<<< HEAD
function costfunction(;C, max_travel_rate, infection_period = 29,
    reinfection_probability = 0.05, detection_time = 14, death_rate = 0.02,
    Is=[zeros(Int, C-1)..., 1], seed = 19,
  )
  params = create_params(C=8, max_travel_rate=0.01)
=======
include("RobSIR.jl")
>>>>>>> abb9ac465b7c513aab427d1dfc858dac8db3b788

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