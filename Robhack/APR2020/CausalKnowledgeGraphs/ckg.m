%Octave
%https://medium.com/@samuellynnevans/a-simple-vectorised-neural-network-in-octave-in-11-lines-of-code-b17ed9894f48

%X = [0 1 1 0;0 0 1 1;1 1 1 1];
X = [0 0 1;0 1 1;1 0 1;1 1 1];
y = [0 1 1 0]';
iter = 50000;


%function[output]=ckg(X,y,iter)



%initialise theta to random values
theta_one = rand(3,3);
theta_two = rand(3,1);

for j = 1:length(X);

%assign the transposed input to the input layer (a{1})
a{1} = X';
%a{1} = X(:,j)'

%loop to carry out gradient descent iter times
for i = 1:iter;

%forward propagation to calculate output using sigmoid function
a{2} = 1./ (1 + e.^-(theta_one .* a{1}));
%a2 = 1./ (1 + e.^-(theta_one .* a1));

a{3} = 1./ (1 + e.^-(theta_two .* a{2}));
%a3 = 1./ (1 + e.^-(theta_one .* a2));

%back propagation to calculate error
%error_three = a{3} - y';
error_three = (y - a{3}) * (a{3} * (1 - a{3}))
%error_three = a3 - y';

%error_two = (theta_two' * error_three) .* a{2} .* (1 - a{2})
error_two = (error_three .* theta_two') * a{2} * (1 - a{2})
%error_two = (theta_two' .* error_three) .* a2 .* (1 - a2);

%Substract practical derivatives from theta
theta_one = theta_one - (error_two * a{1}');
%theta_one = theta_one - (error_two * a1');

theta_two = theta_two - (error_three * a{2}');
%theta_one = theta_two - (error_three * a2');

output(1,j) = sum(sum(a{3}));
#pause
%output = a3
end
output
#pause
end
