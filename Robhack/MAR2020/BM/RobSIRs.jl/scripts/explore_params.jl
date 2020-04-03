using RobSIRs
using CSV
using JLD2
using FileIO
resultdir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\BM\\RobSIRs.jl\\results"
datadir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\DI\\data\\transformed_data"

nsims = 1000
for sim in 1:nsims
  parameters = RobSIRs.load_params(
    bs=0.0:0.0001:1.0,
    ss=0.01:0.0001:1.0,
    dss=0.0:0.0001:1.0,
    dis=0.001:0.0001:1.0,
    drs=0.0:0.0001:1.0,
    datadir=datadir);

  model = create_model(parameters=parameters);
  model, IRD_per_node = step!(model, 100);
  results_df = RobSIRs.cases2df(model, IRD_per_node, datadir=datadir);
  # save the result
  simfile = joinpath(resultdir, "sim_$sim.csv")
  CSV.write(simfile, results_df)
  paramfile = joinpath(resultdir, "param_$sim.jld2")
  save(paramfile, "sim", parameters)
end