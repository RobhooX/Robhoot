using Distributed
<<<<<<< HEAD
Distributed.addprocs(16)
=======
Distributed.addprocs()
>>>>>>> 61a45055a59605613dca14b8252d0d73f8af83a3
@everywhere using EvoDynamics
@everywhere using Pkg
@everywhere Pkg.activate(".")
@everywhere using Statistics
@everywhere using Agents
@everywhere using DataFrames
@everywhere using CSV
@everywhere include("collection_functions.jl")
@everywhere include("init.jl")

@everywhere param_file = "initialization.yml"
if !isfile(param_file)
  data = create_dicts()
  EvoDynamics.YAML.write_file(param_file, data)
end

<<<<<<< HEAD
_, results, model = EvoDynamics.runmodel(param_file, adata=nothing, mdata=[count_per_site, age_per_site, migration_rates_per_site, abiotic_value_per_site,  biotic_value_per_site], when = [0,1,20,40,60,80,100], replicates=15, parallel=true)
=======
_, results, model = EvoDynamics.runmodel(param_file, adata=nothing, mdata=[count_per_site, age_per_site, migration_rates_per_site, abiotic_value_per_site,  biotic_value_per_site], when = [0,1,20,40,60,80,100], replicates=100, parallel=true)
>>>>>>> 61a45055a59605613dca14b8252d0d73f8af83a3

# # reshape the output
# base_names=["age_per_site", "migration_rates_per_site", "abiotic_value_per_site"]
# similar_columns = vcat([:step], Symbol.(base_names))

# df = add_columns(model, results[:, similar_columns], base_names=base_names, summary_functions=["mean", "std", "median"])
# df_count_only = add_columns(model, results[:, [:step, :count_per_site]], base_names=["count_per_site"], summary_functions=["identity"])

# # write to file
# CSV.write("results/all_except_N.csv", df)
# CSV.write("results/N.csv", df_count_only)
