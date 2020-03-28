using RobSIRs

# parameters = RobSIRs.random_params(C=200);
parameters = RobSIRs.load_params();
model = create_model(parameters=parameters)
model, IRD_per_node = step!(model, 10);