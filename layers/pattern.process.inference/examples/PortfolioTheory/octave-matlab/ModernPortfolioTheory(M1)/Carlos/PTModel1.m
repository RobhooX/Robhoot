%PT
%Random time series
%1 Each stock of fund an idealized Gaussian distribution of returns
%Check for each time series: do stock follow Gaussian dist of returns?
T=1095;%sample size
S=25;%number stocks or funds
t = (1:T)';
y = zeros(T,S);
for i = 1:S;
a = unifrnd(0,1)*0.05;%mean
y(:,i)=(i*randn(T,1) + a*t) + 100;
end
subplot(2,2,1)
%for u = 1:S;
plot(t,y)
title('Time series','fontsize',12)
ylabel('Price','fontsize',12)
xlabel('Time','fontsize',12)
%end
%2 Calculate return distribution for diff time intervals 1d 2d 3d ....nd
%vector of security mean expected returns
zbar=zeros(1,S);
for r = 1:S;
    zbar(1,r) = (y(T,r) - y(1,r))/3;
    %zbar(1,r) = mean(y(:,r));
end
zbar = zbar';

%4 Calculate var cov matrix from T matrix (assuming multivariately Gaussian distributed random variables)
CM=zeros(S,S);
for c =1:S-1;
   for c1=c+1:S;
       CM(c,c1) = cov(y(:,c),y(:,c1));
   end
end

for c2 =1:S;
   CM(c2,c2) = var(y(:,c2));
end
M = CM+CM';
stdevs=sqrt(diag(M));

%6 standarize the var cov matrix using correlation coef (-1,1)
%pxy = Cov(X,Y)/((sqrt(Var(X))*(sqrt(Var(Y))): 1 perfect positive linear dep
%COM=zeros(S,S);
%COM1=zeros(S,S);
%for c =1;S-1;
%    for c1=c+1:S;
%        COM(c,c1) = M(c,c1)/(sqrt(var(y(:,c)))*sqrt(var(y(:,c1))));
%        COM1(c,c1) = M(c,c1)/(std(y(:,c))*std(y(:,c1)));
%    end
%end
%CORRM=COM1+COM1';
%CORRM(1:S+1:end) = 1;
%C = CORRM;

%7Weight vector or unity vector must have same length as zbar
unity = ones(length(zbar),1);

%size(M)
%stdevs
%zbar


%8 Calculate efficient frontier
A = unity'*M^-1*unity; %>0
B = unity'*M^-1*zbar; %>0
C = zbar'*M^-1*zbar; %>0
D = A*C-B^2;
%mu = (1:300)/10;
mu = linspace(1,75,S);

%9 Plot efficient frontier
minvar = ((A*mu.^2)-2*B*mu+C)/D;
minstd = sqrt(minvar);

subplot(2,2,2)
%hold off
%plot(minstd,mu,stdevs,zbar,'*')
plot(stdevs,zbar,'*')
hold on
plot(minstd,mu,'-')
title('Efficient frontier Individual securities','fontsize',12)
ylabel('Expected return (%)','fontsize',12)
xlabel('Standard deviation (%)','fontsize',12)

