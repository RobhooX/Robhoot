using RobSIRs
using Agents
using VegaLite

datadir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\DI\\data\\transformed_data"

# Running a single simulation.
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
data = step!(model, agent_step!, 50, [:pos, :I, :R, :D]);

p = data |> @vlplot() +
[@vlplot(mark = :line,
  x = "step:n",
  y = {:I,axis = {title = "Number of infected"}},
  color = {"pos:n",legend = false});
@vlplot(mark = :line,
  x = "step:n",
  y = {:D, axis = {title = "Number of death"}},
  color = {"pos:n", legend = false});
@vlplot(mark = :line,
  x = "step:n",
  y = {:R, axis = {title = "Number of recovered"}},
  color = {"pos:n", legend = false})]
