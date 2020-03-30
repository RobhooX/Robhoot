using RobSIRs
using VegaLite

# parameters = RobSIRs.random_params(C=200);
parameters = RobSIRs.load_params();
model = create_model(parameters=parameters)
model, IRD_per_node = step!(model, 100);

# plot
results_df = RobSIRs.cases2df(model, IRD_per_node);

p = results_df |> @vlplot() +
[@vlplot(
  mark = :line,
  x = :time,
  y = {:infected,
    axis = {
      title = "Number of infected"
    },
    scale = {type="sqrt"}
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
    },
    scale = {type="sqrt"}
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
    },
    scale = {type="sqrt"}
  },
  color = {:location,
    legend = false
  }
)]
