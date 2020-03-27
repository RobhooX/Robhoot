include("../src/model.jl")

parameters = random_params(C=200);
model = create_model(parameters=parameters)
model, infected = step!(model, 10)