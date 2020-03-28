using RobSIRs

# parameters = RobSIRs.random_params(C=200);
parameters = RobSIRs.load_params();
model = create_model(parameters=parameters)
model, infected = step!(model, 10)