#=
 Random time series
 Usage:
	all_plots(T=1095, S=25)
	
=#

using PyPlot
plt = PyPlot

"""
	Each stock of fund an idealized Gaussian distribution of returns
	Check for each time series: do stock follow Gaussian dist of returns?


	# Parameters:

	T: sample size (number of datapoints in time series. You may need to add zeros to smaller datasets, so that all of them are the same length )

	S: number stocks or funds or cyrptocurrencies
"""
function produce_random_data(T, S)
	y = zeros(T, S)  # this will be your data, if you do not want to make random variables.
	
	for i in 1:S
		a = rand()*0.05  # mean
		y[:, i] = ((i * randn(T)) + (a * (1:T))) + 100;
	end
	return y
end


"""
	Calculate return distribution for diff time intervals 1d 2d 3d ....nd

	# Parameters:

	y: data

	S: number stocks or funds or cyrptocurrencies
"""
function calculate_return(y, S, T)
	zbar=zeros(1,S)  # vector of security mean expected returns
	for r in 1:S
		zbar[1,r] = (y[T, r] - y[1, r])/3  # 3 is time interval. The last value and the first value for each coin / stock
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
	M = CM+CM';
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
	mu = transpose(collect(linspace(1, 75, S)))

	# Plot efficient frontier
	minvar = ((A*(mu.^2))-2*(B*mu).+C)/D
	minstd = sqrt.(minvar)

	return minvar, minstd, mu
end


function all_plots(;T=1095, S=25)
	# Produce data
	y = produce_random_data(T, S)

	# Calculate efficient frontier
	zbar = calculate_return(y, S, T)
	stdevs, M = var_cov_mat(y, S)
	minvar, minstd, mu = efficient_frontier(zbar, M, S)

	# Plots
	fig = plt.figure(figsize=(20,10))
	fig1 = fig[:add_subplot](211)
	fig1[:plot](1:T, y, alpha=0.5, linewidth=0.3)
	plt.title("Random time series", fontsize=12)
	plt.xlabel("Time", fontsize=12)
	plt.ylabel("Price", fontsize=12)

	fig2 = fig[:add_subplot](212)
	fig2[:scatter](stdevs, zbar, color="red")
	fig2[:plot](minstd', mu', linewidth=2, color="k")
	plt.title("Efficient frontier Individual securities", fontsize=12)
	plt.xlabel("Standard deviation (%)", fontsize=12)
	plt.ylabel("Expected return (%)", fontsize=12)
	plt.savefig("random_time_series.pdf", dpi=300)
	plt.close()
end