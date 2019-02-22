#PT
#Random time series
#1 Each stock of fund an idealized Gaussian distribution of returns
#Check for each time series: do stock follow Gaussian dist of returns?
T=1095#sample size
S=25#number stocks or funds
t = (1:T)
y = zeros(T,S)
for i in 1:S
a = rand()*0.05;#mean
y[:,i] = ((i*randn(T)) + (a*t)) + 100;
end

using Plots
plot(t,y)
#savefig("randomtimeseries.pdf")
#title('Time series','fontsize',12)
#ylabel('Price','fontsize',12)
#xlabel('Time','fontsize',12)

#2 Calculate return distribution for diff time intervals 1d 2d 3d ....nd
#vector of security mean expected returns
zbar=zeros(1,S)
for r in 1:S
    zbar[1,r] = (y[T,r] - y[1,r])/3
    #zbar(1,r) = mean(y(:,r));
end
zbar = zbar';

#3 Calculate var cov matrix from T matrix (assuming multivariately Gaussian distributed random variables)
CM=zeros(S,S)
for c in 1:S-1
   for c1 in c+1:S
       CM[c,c1] = cov(y[:,c],y[:,c1])
   end
end

for c2 in 1:S
   CM[c2,c2] = var(y[:,c2])
end
M = CM+CM'
stdevs=sqrt.(diag(M))

#4 Weight vector or unity vector must have same length as zbar
unity = ones(length(zbar))

#5 Calculate efficient frontier
A = unity'*M^-1*unity #>0
B = unity'*M^-1*zbar #>0
C = zbar'*M^-1*zbar #>0
D = A*C-B^2
mu = transpose(collect(linspace(1,75,S)))

#6 Plot efficient frontier

minvar = (((A*mu).^2)-2*(B*mu).+C)/D;
minstd = sqrt.(minvar)

#subplot(2,2,2)
#hold off
#plot(minstd,mu,stdevs,zbar,'*')

#plot(stdevs,zbar,'linewidth=2')
#hold on
#plot(minstd,mu)

#title('Efficient frontier Individual securities','fontsize',12)
#ylabel('Expected return (#)','fontsize',12)
#xlabel('Standard deviation (#)','fontsize',12)



