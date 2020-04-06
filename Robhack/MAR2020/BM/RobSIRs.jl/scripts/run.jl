using RobSIRs
using Agents
using VegaLite

datadir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\DI\\data\\transformed_data"

# Running a single simulation.
parameters = RobSIRs.load_params(
  bs=rand(0.0:0.0001:0.99, 196),  # min max of uniform distribution
  ss=rand(0.01:0.0001:0.99, 196),
  es=rand(0.01:0.0001:0.99, 196),
  is=rand(0.01:0.0001:0.99, 196),
  as=rand(0.01:0.0001:0.99, 196),
  dss=rand(0.0:0.0, 196),
  dincs=rand(0.0:0.0, 196),
  dlats=rand(0.0:0.0, 196),
  dis=rand(0.001:0.0001:0.99, 196),
  drs=rand(0.0:0.0, 196),
  datadir=datadir);

model = create_model(parameters=parameters);
data = step!(model, agent_step!, 50, [:pos, :I, :R, :D]);

p = data |> @vlplot() +
[@vlplot(
  mark = :line,
  x = "step:n",
  y = {:I,
    axis = {
      title = "Number of infected"
    }
  },
  color = {"pos:n",
    legend = false
  }
);
@vlplot(
  mark = :line,
  x = "step:n",
  y = {:D,
    axis = {
      title = "Number of death"
    }
  },
  color = {"pos:n",
    legend = false
  }
);
@vlplot(
  mark = :line,
  x = "step:n",
  y = {:R,
    axis = {
      title = "Number of recovered"
    }
  },
  color = {"pos:n",
    legend = false
  }
)]
