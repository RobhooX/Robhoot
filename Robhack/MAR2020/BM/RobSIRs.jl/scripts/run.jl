using RobSIRs
using VegaLite
using CSV
using DataFrames
using Random

function print_outputs(df, replicate)
   output_dir="../results/"
   filename = output_dir*"output_"*string(replicate,pad=7)*".csv"
   CSV.write(filename,df)
end

function runfunction(rep)
   parameters = RobSIRs.load_params("../../DI/data/transformed_data",rep);
   model = create_model(parameters=parameters)
   model, IRD_per_node = step!(model, 360);
   # outputs 
   results_df = RobSIRs.cases2df(model, IRD_per_node);
   filter!(row -> row[:time] == 360, results_df)
   output_df = hcat(convert(DataFrame,[parameters[:Rs] parameters[:Is] parameters[:bs] parameters[:ss] parameters[:as] parameters[:dss] parameters[:dis] parameters[:drs]]), results_df)
   print_outputs(output_df, rep)
end

# parameters = RobSIRs.random_params(C=200);
nrep = 100
for rep in 1:nrep
   runfunction(rep)
end
#
#p = results_df |> @vlplot() +
#[@vlplot(
#  mark = :line,
#  x = :time,
#  y = {:infected,
#    axis = {
#      title = "Number of infected"
#    }
#  },
#  color = {:location,
#    legend = false
#  }
#);
#@vlplot(
#  mark = :line,
#  x = :time,
#  y = {:dead,
#    axis = {
#      title = "Number of death"
#    }
#  },
#  color = {:location,
#    legend = false
#  }
#);
#@vlplot(
#  mark = :line,
#  x = :time,
#  y = {:recovered,
#    axis = {
#      title = "Number of recovered"
#    }
#  },
#  color = {:location,
#    legend = false
#  }
#)]
#
#### Plotting histogram 
#
#
##getting the last time step
#filter!(row -> row[:time] == 50, results_df)
#hist = results_df |> @vlplot(:bar, x={:infected, bin=true}, y="count()")
#
#
