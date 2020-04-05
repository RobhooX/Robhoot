using RobSIRs
using Agents
using VegaLite
using CSV
using FilePathsBase
using JLD2
using FileIO

# Running a single simulation.
datadir = "../../DI/data/transformed_data"
parameters = RobSIRs.load_params(
  bs=0.0:0.0001:1.0,  # min max of uniform distribution
  ss=0.01:0.0001:1.0,
  as=0.01:0.0001:1.0,
  dss=0.0:0.0001:1.0,
  dis=0.001:0.0001:1.0,
  drs=0.0:0.0001:1.0,
  datadir=datadir);

model = create_model(parameters=parameters);
data = step!(model, agent_step!, 50, [:pos, :I, :R, :D]);

p = data |> @vlplot() +
[@vlplot(
  mark = :line,
  x = :step,
  y = {:I,
    axis = {
      title = "Number of infected"
    }
  },
  color = {:pos,
    legend = false
  }
);
@vlplot(
  mark = :line,
  x = :step,
  y = {:D,
    axis = {
      title = "Number of death"
    }
  },
  color = {:pos,
    legend = false
  }
);
@vlplot(
  mark = :line,
  x = :step,
  y = {:R,
    axis = {
      title = "Number of recovered"
    }
  },
  color = {:pos,
    legend = false
  }
)]
