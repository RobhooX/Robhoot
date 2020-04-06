using RobSIRs
using CSV
using JLD2
using FileIO
resultdir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\BM\\RobSIRs.jl\\results"
datadir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\DI\\data\\transformed_data"

nsims = 1000
for sim in 1:nsims
  parameters = RobSIRs.load_params(
    bs=0.0:0.0001:0.99,  # min max of uniform distribution
    ss=0.01:0.0001:0.99,
    es=0.01:0.0001:0.99,
    is=0.01:0.0001:0.99,
    as=0.01:0.0001:0.99,
    dss=0.0:0.0,
    dincs=0.0:0.0,
    dlats=0.0:0.0,
    dis=0.001:0.0001:1.0,
    drs=0.0:0.0,
  datadir=datadir);

  model = create_model(parameters=parameters);
  data = step!(model, agent_step!, 100, [:pos, :I, :R, :D]);
  # save the result
  simfile = joinpath(resultdir, "sim_$sim.csv")
  CSV.write(simfile, data)
  paramfile = joinpath(resultdir, "param_$sim.jld2")
  save(paramfile, "sim", parameters)
end