function costfunction(;C, max_travel_rate, infection_period = 30,
    reinfection_probability = 0.05, detection_time = 14, death_rate = 0.02,
    Is=[zeros(Int, C-1)..., 1], seed = 19,
  )
  params = create_params(C=8, max_travel_rate=0.01)

model = model_initiation(;params...)

data_to_collect = Dict(:status => [infected, recovered, length])

