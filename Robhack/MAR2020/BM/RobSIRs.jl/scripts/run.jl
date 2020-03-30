using RobSIRs
using VegaLite

# parameters = RobSIRs.random_params(C=200);
parameters = RobSIRs.load_params(datafolder);
model = create_model(parameters=parameters)
model, IRD_per_node = step!(model, 100);

# plot
results_df = RobSIRs.cases2df(model, IRD_per_node);

p = @vlplot(
  data = results_df,
  mark = :line,
  x = :time,
  y = {:infected,
    axis = {
      title = "Number of infected"
    }
  },
  color = :location
)
# save("infected.pdf", p)
