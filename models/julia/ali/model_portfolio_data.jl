using PyPlot
plt = PyPlot
include("analyze.jl")

"""
	Calculate return distribution for diff time intervals 1d 2d 3d ....nd

	# Parameters:

	y: data

	S: number stocks or funds or cyrptocurrencies
"""
function calculate_return(y, S, T)
	zbar=zeros(1,S)  # vector of security mean expected returns
	for r in 1:S
		first_nonzer_in_row_r = 1
		for jj in 1:length(y[:, r])
			if y[jj, r] > 0
				first_nonzer_in_row_r = jj
				break
			end
		end

		zbar[1,r] = (y[T, r] - y[first_nonzer_in_row_r, r])/3  # 3 is time interval. The last value and the first value for each coin / stock
	end
	zbar = zbar';
	return zbar
end


"""
	Calculate var cov matrix from T matrix (assuming multivariately Gaussian distributed random variables)

	# Parameters:

	y: Data

	S: number stocks or funds or cyrptocurrencies
"""
function var_cov_mat(y, S)
	CM = zeros(S, S)
	for c in 1:S-1
		for c1 in c+1:S
			CM[c,c1] = cov(y[:,c], y[:,c1])
		end
	end

	for c2 in 1:S
		CM[c2,c2] = var(y[:,c2])
	end
	M = CM + CM';
	stdevs=sqrt.(diag(M))

	return stdevs, M
end


"""
	Calculate efficient frontier

	# Parameters

	zbar: return value for each stock. A vector as long as the number of stocks. See calculate_return

	M: ?

	S: number of stocks
"""
function efficient_frontier(zbar, M, S)
	unity = ones(length(zbar), 1)  # Weight vector or unity vector must have same length as zbar
	A = (unity'*(M^-1))*unity #>0  # TODO: Julia cannot compute M^-1, because it cannot compute
	B = (unity'*(M^-1))*zbar #>0
	C = (zbar'*(M^-1))*zbar #>0
	D = (A*C)-(B^2)
	mu = transpose(collect(linspace(1, 75, S)))  # TODO: why 75? what parameter is it?

	# Plot efficient frontier
	minvar = ((A*(mu.^2))-2*(B*mu).+C)/D
	minstd = sqrt.(minvar)

	return minvar, minstd, mu
end


function all_plots(;data_dir="../data/histoDay_all")

	# get data
	y = dfs_to_matrix(data_dir);
	y_size = size(y)
	T = y_size[1]  # sample size (number of datapoints in time series. You may need to add zeros to smaller datasets, so that all of them are the same length )
	S = y_size[2]  # number stocks or funds or cyrptocurrencies

	# Calculate efficient frontier
	zbar = calculate_return(y, S, T)
	stdevs, M = var_cov_mat(y, S)
	minvar, minstd, mu = efficient_frontier(zbar, M, S)

	# Plots
	fig = plt.figure(figsize=(20,10))
	fig1 = fig[:add_subplot](211)
	fig1[:plot](1:T, y, alpha=0.5, linewidth=0.3)
	plt.title("Random time series", fontsize=12)
	plt.yscale("log", ybase=10)
	plt.xlabel("Time", fontsize=12)
	plt.ylabel("Price", fontsize=12)

	fig2 = fig[:add_subplot](212)
	fig2[:scatter](stdevs, zbar, color="red")
	fig2[:plot](minstd', mu', linewidth=2, color="k")
	plt.title("Efficient frontier Individual securities", fontsize=12)
	plt.xlabel("Standard deviation (%)", fontsize=12)
	plt.ylabel("Expected return (%)", fontsize=12)
	plt.savefig("time_series.pdf", dpi=300)
	plt.close()
end