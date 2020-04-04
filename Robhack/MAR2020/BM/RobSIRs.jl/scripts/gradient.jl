using RobSIRs
using FiniteDifferences

resultdir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\BM\\RobSIRs.jl\\results"
datadir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\DI\\data\\transformed_data"

# a random trajectory of the number of infected of a country
timesteps = 10
traj = [1.01*i^2 for i in 1:timesteps+1];

function cost(bs=rand(0.0:0.0001:1.0, 196),
  as=rand(0.0:0.0001:1.0, 196),
  ss=rand(0.01:0.0001:1.0, 196),
  dss=rand(0.0:0.0001:1.0, 196),
  dis=rand(0.001:0.0001:1.0, 196),
  drs=rand(0.0:0.0001:1.0, 196))

  parameters = RobSIRs.load_params(bs=bs, as=as, ss=ss, dss=dss, dis=dis,
    drs=drs, datadir=datadir);

  model = create_model(parameters=parameters)
  model, IRD_per_node = step!(model, timesteps);
  country1I = [IRD_per_node[i][1][12] for i in 1:timesteps+1]
  diff = sqrt(sum((country1I .- traj).^2))
  return diff
end

# initialize random parameters
bs=rand(0.0:0.0001:1.0, 196);
as=rand(0.0:0.0001:1.0, 196);
ss=rand(0.01:0.0001:1.0, 196);
dss=rand(0.0:0.0001:1.0, 196);
dis=rand(0.001:0.0001:1.0, 196);
drs=rand(0.0:0.0001:1.0, 196);
cost(bs, as, ss, dss, dis, drs)

for iter in 1:10
  # Take their gradients
  grads = grad(central_fdm(5, 1), cost, bs, as, ss, dss, dis, drs)
  # update params
  α = 0.5
  bs .-= α*grads[1]
  as .-= α*grads[2]
  ss .-= α*grads[3]
  dss .-= α*grads[4]
  dis .-= α*grads[5]
  drs .-= α*grads[6]
end
