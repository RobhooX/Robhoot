
%----------------------------------------
%DEEPBIOS:  APRIL-MAY 2021
%Prototype KINN
%----------------------------------------

%--------------------------------
%IMPORT: Species pairs
%CHECK NAME DATA
%Haddock Cod Whiting 
%--------------------------------

%-----------------------------------------------------
%IMPORT: LONG-LAT DISTANCE MATRIX
%-----------------------------------------------------

%---------------------------------------
%IMPORT: BAYESIAN GRAPH
%---------------------------------------

%------------------------------------------------------------------
%IMPORT: CONNECT BAYESIAN GRAPH TO KINN	
%Check preprocessing.jl
%haul = CSV.read(haul_file, DataFrame);
 %lengths_small = CSV.read(lengths_file_small, DataFrame);
%------------------------------------------------------------------


%DYNAMICS
%--------------------------------------------------------------
%Deepbios: Metacommunity Leslie Matrix Dynamics
%--------------------------------------------------------------


%---------------------------------------------------------------------------
%Import distance matrix ------LONG-LAT DISTANCE MATRIX
%S = X;%Sites
A= randn(10)+10;A = A+A';A(1:10+1:10*10) = 0;
%--------------------------------------------------------------------------

%Import P/A & size class & parameters
T = 1000;
Ao = [6.2];%#offspring per adult
Pjl = [0.65];%Proportion larva to juvenile
Paj = [0.25];%Proportion juvenile to adult

L = [0 0 Ao;Pjl 0 0;0 Paj 0];
X = zeros(3,T);Y = zeros(3,T);
X(:,1) = [10000 1000 10];Y(:,1) = [10000 1000 10];


m = 0.5;%planctonic larvae migration
%Dynamics------Cartoon--
%for k = 2:T;
%    X(:,k) = L*X(:,k-1);
%end
%t = 1:T;
%plot(t,X(1,:),'r')
%hold on
%plot(t,X(2,:),'k')
%hold on
%plot(t,X(3,:),'g')
%----------------------

%Dynamics
for k = 2:T;
    r = unifrnd(0,1);
    if r <= m;
       %migration yes
       X(1,k-1) = X(1,k-1) + m*Y(1,k-1);
       X(:,k) = L*X(:,k-1);
       Y(1,k-1) = (1 - m)*Y(1,k-1); 
       Y(:,k) = L*Y(:,k-1);
       
       %test symmetry
       Y(1,k-1) = Y(1,k-1) + m*X(1,k-1);
       Y(:,k) = L*Y(:,k-1);
       X(1,k-1) = (1 - m)*X(1,k-1); 
       X(:,k) = L*X(:,k-1);     
    else 
       X(:,k) = L*X(:,k-1);
       Y(:,k) = L*Y(:,k-1);
    end
end






%-------------------------
%PLOTTING
%-------------------------
subplot(2,2,1)
t = 1:T;
plot(t,X(1,:),'r')
hold on
plot(t,X(2,:),'k')
hold on
plot(t,X(3,:),'g')
axis([0 1000 0 100000])

subplot(2,2,2)
plot(t,Y(1,:),'r')
hold on
plot(t,Y(2,:),'k')
hold on
plot(t,Y(3,:),'g')
axis([0 1000 0 100000])
