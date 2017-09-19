# using PyPlot
# plt = PyPlot
using Plots
include("analyze.jl")

data_dir = "../data/histoDay_all"
y = dfs_to_matrix(data_dir)
y_size = size(y)
T = y_size[1]  # sample size (number of datapoints in time series. You may need to add zeros to smaller datasets, so that all of them are the same length )
S = y_size[2]  # number stocks or funds or cyrptocurrencies

t = 1:T

# fig = plt.subplot(2,2,1)
plot(t, y)
savefig("time_series.pdf")
# plt.title('Time series','fontsize',12)
# plt.ylabel('Price','fontsize',12)
# plt.xlabel('Time','fontsize',12)
# plt.close()


# 2 Calculate return distribution for diff time intervals 1d 2d 3d ....nd
# vector of security mean expected returns
zbar=zeros(1,S)
for r in 1:S
    zbar[1,r] = (y[T, r] - y[1,r])/3  # 3 is time interval. The last value and the first value for each coin / stock TODO:
    #zbar(1,r) = mean(y(:,r));
end
zbar = zbar';

# 3 Calculate var cov matrix from T matrix (assuming multivariately Gaussian distributed random variables)
CM=zeros(S,S)
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

# 4 Weight vector or unity vector must have same length as zbar
unity = ones(length(zbar), 1)

# 5 Calculate efficient frontier
A = unity'*M^-1*unity #>0
B = unity'*M^-1*zbar #>0
C = zbar'*M^-1*zbar #>0
D = A*C-B^2
#mu = (1:300)/10;
mu = transpose(collect(linspace(1,75,S)))

# 6 Plot efficient frontier
minvar = (((A*mu).^2)-2*(B*mu).+C)/D
minstd = sqrt.(minvar)

# TODO
plot(stdevs,zbar)
plot(minstd, mu)
savefig("efficient_frontier.pdf")

# title('Efficient frontier Individual securities','fontsize',12)
# ylabel('Expected return (%)','fontsize',12)
# xlabel('Standard deviation (%)','fontsize',12)
