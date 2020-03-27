using Zygote
include("../src/model.jl")

function cost(;C=100)
  parameters = random_params(C=C);
  model = create_model(parameters=parameters)
  model, infected = step!(model, 10)
  sum(infected)
end

cost(C=100)

gradient(C -> cost(C=C), 100)  # FIXME