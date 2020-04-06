using RobSIRs
using FiniteDifferences
using Agents
using CSV
using DataFrames

resultdir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\BM\\RobSIRs.jl\\results"
datadir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\DI\\data\\transformed_data"

# a random trajectory of the number of infected of a country
timesteps = 10
traj = [1.01*i^2 for i in 1:timesteps+1];

function cost(
  bs=rand(0.0:0.0001:1.0, 196),
  as=rand(0.0:0.0001:1.0, 196),
  ss=rand(0.01:0.0001:1.0, 196),
  es=rand(0.01:0.0001:1.0, 196),
  is=rand(0.01:0.0001:1.0, 196),
  dis=rand(0.001:0.0001:1.0, 196),
  )

  dss = fill(0.0, 196)
  dlats = fill(0.0, 196)
  dincs = fill(0.0, 196)
  drs = fill(0.0, 196)
  parameters = RobSIRs.load_params(bs=bs, as=as, es=es, is=is, ss=ss, dss=dss, dis=dis,
    drs=drs, dincs=dincs, dlats=dlats, datadir=datadir);

  model = create_model(parameters=parameters);
  data = step!(model, agent_step!, timesteps, [:pos, :I]);
  country1I = view(data.I, data.pos .== 12)
  diff = sqrt(sum((country1I .- traj).^2))
  return diff
end

# initialize random parameters
bs=rand(0.0:0.0001:1.0, 196);
es=rand(0.0:0.0001:1.0, 196);
is=rand(0.0:0.0001:1.0, 196);
as=rand(0.0:0.0001:1.0, 196);
ss=rand(0.01:0.0001:1.0, 196);
dis=rand(0.001:0.0001:1.0, 196);
cost(bs, as, ss, es, is, dis)

α = 0.5
for iter in 1:100
  # Take their gradients
  grads = grad(backward_fdm(2, 1), cost, bs, as, ss, es, is, dis)
  # update params
  bs .-= α*grads[1]
  as .-= α*grads[2]
  ss .-= α*grads[3]
  es .-= α*grads[4]
  is .-= α*grads[5]
  dis .-= α*grads[6]
end

params = DataFrame([as,bs,ss,es,is,dis], [:as, :bs, :ss, :es, :is, :dis])
CSV.write("fitted_params.csv", params)