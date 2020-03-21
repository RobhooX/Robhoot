# This code fits lines to cryptocoin prices to find the best deals for long term investment.
using DataFrames
# using PyPlot
# using ScikitLearn
# using ScikitLearn: fit!, predict
# using Distributions
# using PyCall, JLD, PyCallJLD

# # use analyze.jl to get data_matrix and df_names and volume_matrix
# df = DataFrame(data_matrix);
# writetable("../results/dataAll_10122017.txt", df, header=false, separator='\t')
# df_v = DataFrame(volume_matrix);
# writetable("../results/data_volume_10122017.txt", df_v, header=false, separator='\t')
# names_file = "../results/dataNames_10122017.txt"
# open(names_file, "w")
# open(names_file, "a") do myfile
#   for item in df_names
#     println(myfile, item)
#   end
# end

df = readtable("../results/dataAll_10122017.txt", header=false, separator='\t');
df_v = readtable("../results/data_volume_10122017.txt", header=false, separator='\t');
df_names = readlines("../results/dataNames_10122017.txt")
## rename columns
cnames = names(df)
for (index, nn) in enumerate(df_names)
  rename!(df, cnames[index], Symbol(nn))
end
cnames = names(df_v)
for (index, nn) in enumerate(df_names)
  rename!(df_v, cnames[index], Symbol(nn))
end

######################################################
### A linear regression find highest growing coins ###
######################################################
## Choose coins older than n months
min_age = 30 * 9
dfnames = names(df)

coins = DataFrame()
coins_v = DataFrame()
new_names = []
for cc in dfnames
  if df[cc][end-min_age] > 0
    coins = hcat(coins, df[cc])
    coins_v = hcat(coins_v, df_v[cc])
    push!(new_names, cc)
  end
end

## rename columns
cnames = names(coins)
for (index, nn) in enumerate(new_names)
  rename!(coins, cnames[index], Symbol(nn))
  rename!(coins_v, cnames[index], Symbol(nn))
end

x = 1:min_age+1
intercepts = []
slopes = []
slopes_v = []
for coin in 1:size(coins)[2]
  y = coins[coin][end-min_age:end]
  j = linreg(x, y)
  push!(intercepts, j[1])
  push!(slopes, j[2])
  y2 = coins_v[coin][end-min_age:end]
  j2 = linreg(x, y2)
  push!(slopes_v, j2[2])
end

sorted_lists = sort(collect(zip(slopes, intercepts, slopes_v, names(coins))), rev=true)
outfile = "../results/sorted_conis_slopes_$(min_age)days.csv"
j = open(outfile, "w")
println(j, join(["p_slope", "p_intc", "v_slope", "name", "p_latest", "v_latest", "age"], ","))
close(j)
open(outfile, "a") do ff
  for item in sorted_lists
    println(ff, join(vcat(collect(item), coins[item[end]][end], coins_v[item[end]][end], length(find(coins[Symbol(item[4])]))), ","))
  end
end