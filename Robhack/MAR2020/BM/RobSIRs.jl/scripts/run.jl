using RobSIRs
using VegaLite
using CSV
using FilePathsBase
using JLD2
using FileIO

# Running a single simulation.
parameters = RobSIRs.load_params(
  bs=0.0:0.0001:1.0,  # min max of uniform distribution
  ss=0.01:0.0001:1.0,
  as=0.01:0.0001:1.0,
  dss=0.0:0.0001:1.0,
  dis=0.001:0.0001:1.0,
  drs=0.0:0.0001:1.0,
  datadir="../../DI/data/transformed_data");

model = create_model(parameters=parameters)
model, IRD_per_node = step!(model, 50);

# plot
results_df = RobSIRs.cases2df(model, IRD_per_node, datadir="..\\..\\DI\\data\\transformed_data");

p = results_df |> @vlplot() +
[@vlplot(
  mark = :line,
  x = :time,
  y = {:infected,
    axis = {
      title = "Number of infected"
    }
  },
  color = {:location,
    legend = false
  }
);
@vlplot(
  mark = :line,
  x = :time,
  y = {:dead,
    axis = {
      title = "Number of death"
    }
  },
  color = {:location,
    legend = false
  }
);
@vlplot(
  mark = :line,
  x = :time,
  y = {:recovered,
    axis = {
      title = "Number of recovered"
    }
  },
  color = {:location,
    legend = false
  }
)]
