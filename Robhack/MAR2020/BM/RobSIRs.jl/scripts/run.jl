using RobSIRs
using Agents
using VegaLite

datadir = "D:\\projects\\Robhoot\\Robhack\\MAR2020\\DI\\data\\transformed_data"

# Running a single simulation.
parameters = RobSIRs.load_params(
  bs=0.0:0.0001:1.0,  # min max of uniform distribution
  ss=0.01:0.0001:1.0,
  as=0.01:0.0001:1.0,
  dss=0.0:0.0,
  dis=0.001:0.0001:0.3,
  drs=0.0:0.0,
  datadir=datadir);

model = create_model(parameters=parameters);
data = step!(model, agent_step!, 50, [:I, :R, :D, :pos]);

# plot
p = data |> @vlplot() +
[@vlplot(
  mark = :line,
  x = "step:o",
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
  x = "step:o",
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
  x = "step:o",
  y = {:R,
    axis = {
      title = "Number of recovered"
    }
  },
  color = {"pos:n",
    legend = false
  }
)]
