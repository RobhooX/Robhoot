#=
This code evaluates the value of D in var_cov_mat in model_portfolio_data.jl, to find a matrix of data that does not result in negative D.
=#

include("model_portfolio_data.jl")
using ProgressMeter
using PyPlot

function calculate_d(zbar, M, S)
	unity = ones(length(zbar), 1)  # Weight vector or unity vector must have same length as zbar
	A = (transpose(unity) * inv(M) * unity)[1]
	B = (transpose(unity) * inv(M) * zbar)[1]
	C = (transpose(zbar) * inv(M) * zbar)[1]
	D = (A * C) - (B ^ 2)
  return D
end

function get_y(;data_dir="../data/histoDay_all", max_price=10000)

	# get data
	y, y_names = dfs_to_matrix(data_dir, max_price=max_price);

  return y, y_names
end


function return_d(y)
	# Calculate efficient frontier
	zbar, S, T = calculate_return(y);
  stdevs, M = var_cov_mat(y, S)
  d = calculate_d(zbar, M, S)
  return d
end

function main(;data_dir="../data/histoDay_all", max_price=10000)
  y, ynames = get_y();
  d_value = return_d(y)
  d_array = Array{Float64}(0)
  push!(d_array, d_value)
  ndays, nsamples = size(y)
  coin_sizes = []
  for nsample in 1:nsamples
    push!(coin_sizes, find(y[:, nsample])[1])
  end
  unique_sorted_coin_sizes = unique(sort(coin_sizes, rev=true))
  cumulative_indices = []

  progress = Progress(length(unique_sorted_coin_sizes))
  for vv in unique_sorted_coin_sizes
    push!(cumulative_indices, vv)
    vv_indices = sort(findin(coin_sizes, cumulative_indices), rev=true)
    # remove vv_indices from y, and calculate D
    all_columns = collect(1:nsamples)
    for vv_index in vv_indices
      splice!(all_columns, vv_index)
    end
    new_y = y[:, all_columns]
    d_value = return_d(new_y)
    push!(d_array, d_value)
    next!(progress)
  end

  return d_array, unique_sorted_coin_sizes
end


function plot_d_coinSize()
  d_array, removed_coin_sizes = main()
  xs = vcat([2620], removed_coin_sizes)
  plot(xs, d_array)
  savefig("d_values.pdf")
  close()
end
