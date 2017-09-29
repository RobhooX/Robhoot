using PyPlot
plt = PyPlot
include("analyze.jl")

"""
	Calculate return distribution for diff time intervals 1d 2d 3d ....nd

	# Parameters:

	y: data

	# returns
	zbar: return of each coin
	S: number stocks or funds or cyrptocurrencies
	T: sample size (number of datapoints in time series. You may need to add zeros to smaller datasets, so that all of them are the same length )
"""
function calculate_return(y)
	ysize = size(y)
	S = ysize[2]
	T = ysize[1]
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
	return zbar, S, T
end


"""
	Calculate var cov matrix from T matrix (assuming multivariately Gaussian distributed random variables)

	# Parameters:

	y: Data

	S: number stocks or funds or cyrptocurrencies
"""
function var_cov_mat(y, S)
	CM = zeros(S, S)
	for c in 1:S  # -1
		for c1 in c+1:S
			column1 = y[:, c];
			column2 = y[:, c1];
			nonzero1 = find(column1)[1];
			nonzero2 = find(column2)[1];
			smaller_column = maximum([nonzero1, nonzero2])
			CM[c, c1] = cov(column1[smaller_column:end], column2[smaller_column:end])  # only compare rows of two columns that have nonzero values.
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
	A = ((unity'*inv(M))*unity)[1] #>0
	B = ((unity'*inv(M))*zbar)[1] #>0
	C = ((zbar'*inv(M))*zbar)[1] #>0
	D = (A*C)-(B^2)
	mu = transpose(collect(linspace(1, 75, S)))  # TODO: why 75? what parameter is it?

	# Plot efficient frontier
	minvar = ((A*(mu.^2))-2*(B*mu).+C)/D
	minstd = sqrt.(minvar)  # FIXME: minvar has negative values, because D is negative

	return minvar, minstd, mu
end


function all_plots(;data_dir="../data/histoDay_all", max_price=10000)

	# get data
	y, y_names = dfs_to_matrix(data_dir, max_price=max_price);

	# Calculate efficient frontier
	zbar, S, T = calculate_return(y);
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