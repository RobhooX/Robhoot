%// Black-Litterman example code for MatLab (hlbl.m)
%// Copyright (c) Jay Walters, blacklitterman.org, 2008-2014.
%//
%// Redistribution and use in source and binary forms, 
%// with or without modification, are permitted provided 
%// that the following conditions are met:
%//
%// Redistributions of source code must retain the above 
%// copyright notice, this list of conditions and the following 
%// disclaimer.
%// 
%// Redistributions in binary form must reproduce the above 
%// copyright notice, this list of conditions and the following 
%// disclaimer in the documentation and/or other materials 
%// provided with the distribution.
%//  
%// Neither the name of blacklitterman.org nor the names of its
%// contributors may be used to endorse or promote products 
%// derived from this software without specific prior written
%// permission.
%//  
%// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
%// CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
%// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
%// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
%// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
%// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
%// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
%// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
%// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
%// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
%// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
%// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
%// DAMAGE.
%//
%// This program uses the examples from the paper "The Intuition 
%// Behind Black-Litterman Model  Portfolios", by He and Litterman,
%// 1999.  You can find a copy of this  paper at the following url.
%//     http:%//papers.ssrn.com/sol3/papers.cfm?abstract_id=334304
%//
%// For more details on the Black-Litterman model you can also view
%// "The BlackLitterman Model: A Detailed Exploration", by this author
%// at the following url.
%//     http:%//www.blacklitterman.org/Black-Litterman.pdf
%//

%// Main driver program to run all the scenarios from the paper
%// Prints output to the console that should roughly match
%// the tables in paper.

%// Display mode
mode(0);
clc;

%// Take the values from He & Litterman, 1999.
weq = [0.016,0.022,0.052,0.055,0.116,0.124,0.615];
C = [ 1.000 0.488 0.478 0.515 0.439 0.512 0.491;
      0.488 1.000 0.664 0.655 0.310 0.608 0.779;
      0.478 0.664 1.000 0.861 0.355 0.783 0.668;
      0.515 0.655 0.861 1.000 0.354 0.777 0.653;
      0.439 0.310 0.355 0.354 1.000 0.405 0.306;
      0.512 0.608 0.783 0.777 0.405 1.000 0.652;
      0.491 0.779 0.668 0.653 0.306 0.652 1.000];
Sigma = [0.160 0.203 0.248 0.271 0.210 0.200 0.187];
refPi = [0.039 0.069 0.084 0.090 0.043 0.068 0.076];
assets={'Australia';'Canada   ';'France   ';'Germany  ';'Japan    ';'UK       ';'USA      '};
labels={'q        ';'omega/tau';'lambda   ';'vw theta ';'prior theta';...
    'Theil Dst ';'Theil Prb ';'FM Dst   ';'FM Prob  ';'TEV     '};
V = (Sigma' * Sigma) .* C;
[m,n]=size(refPi);
 
%// Risk tolerance of the market from the paper (page 10)
delta= 2.5;

%// Coefficient of uncertainty in the prior estimate of the mean
%// From footnote (8) on page 11
tau = 0.05;

%// Define view 1
%// Germany will outperform the other European markets by 5%
%// Market cap weight the P matrix
%// Results should match Table 4, Page 21
P1 = [0 0 -.295 1.00 0 -.705 0 ];
Q1 = [0.05];
P=P1;
Q=Q1;
Omega = P * tau * V * P' .* eye(1,1);
[Er, ps, w,tt,lambda,theta,tmahal,tmahal_q,tsens,fmahal,fmahal_q,fsens,tev,tevs] = hlblacklitterman(delta, weq, V, tau, P, Q, Omega);
t=[100*Q'; diag(Omega)'/tau; lambda'; theta(1,3:2+size(P,1))];
output(1:n,1)=assets;
output(1:n,2)=num2cell(100*P');
output(1:n,3)=num2cell(100*Er);
output(1:n,4)=num2cell(100*w);
change=(w-weq'/(1+tau));
for i=1:n
    if (abs(change(i)) < 1e-10)
        change(i) = 0;
    end
end
output(1:n,5)=num2cell(100*change);
fprintf(1,'\nView 1 (Matches table 4 in He & Litterman 1999)\n');
fprintf(1,'Country\t\t    P\t   mu\t   w*\tw*-weq/(1+tau)\n');
for i=1:n
fprintf(1,'%s\t%6.4g\t%6.4g\t%6.4g\t%6.4g\n', cell2mat(output(i,1)),cell2mat(output(i,2)),cell2mat(output(i,3)), cell2mat(output(i,4)),cell2mat(output(i,5)));
end
fprintf(1,'%s\t     %g\n',cell2mat(labels(1)),t(1,1));
for i=2:4
fprintf(1,'%s\t     %5.3g\n',cell2mat(labels(i)),t(i,1));
end
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(5)), theta(1,1));
fprintf(1,'%s\t     %5.4g\t%5.4g\n', cell2mat(labels(6)), tmahal, tsens(1));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(7)), tmahal_q);
fprintf(1,'%s\t     %5.4g\t%5.4g\n', cell2mat(labels(8)), fmahal, fsens(1));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(9)), fmahal_q);
fprintf(1,'%s\t     %5.3g\t%5.4g\n', cell2mat(labels(10)), tev, tevs(1));
fprintf(1,'\n');

%// Define view 2
%// Canadian Equities will outperform US Equities by 3%
%// Results should match Table 5, Page 22
P2 = [0.0 1.0 0.0 0.0 0.0 0.0 -1.0 ];
Q2 = [0.03];
P = [P1; P2];
Q = [Q1; Q2];
Omega = P * tau * V * P' .* eye(2,2);
[Er, ps, w,tt,lambda,theta,tmahal,tmahal_q,tsens,fmahal,fmahal_q,fsens,tev,tevs] = hlblacklitterman(delta, weq, V, tau, P, Q, Omega);
t=[100*Q'; diag(Omega)'/tau; lambda'; theta(1,3:2+size(P,1))];
output(1:n,1)=assets;
output(1:n,2:3)=num2cell(100*P');
output(1:n,4)=num2cell(100*Er);
output(1:n,5)=num2cell(100*w);
change=(w-weq'/(1+tau));
for i=1:n
    if (abs(change(i)) < 1e-10)
        change(i) = 0;
    end
end
output(1:n,6)=num2cell(100*change);
fprintf(1,'\nView 1 & 2 (Matches Table 5 in He & Litterman 1999)\n');
fprintf(1,'Country\t\t\t     P\t       mu\t   w\t*w*-weq/(1+tau)\n');
for i=1:n
fprintf(1,'%s\t%6.4g\t%6.4g\t%6.4g\t%6.4g\t%6.4g\n', cell2mat(output(i,1)),cell2mat(output(i,2)),cell2mat(output(i,3)), cell2mat(output(i,4)), cell2mat(output(i,5)), cell2mat(output(i,6)));
end
fprintf(1,'%s\t     %g\t     %g\n',cell2mat(labels(1)),t(1,1),t(1,2));
for i=2:4
fprintf(1,'%s\t     %5.3g\t%5.3g\n',cell2mat(labels(i)),t(i,1),t(i,2));
end
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(5)), theta(1,1));
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(6)), tmahal, tsens(1), tsens(2));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(7)), tmahal_q);
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(8)), fmahal, fsens(1), fsens(2));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(9)), fmahal_q);
fprintf(1,'%s\t     %5.3g\t%5.4g\t%5.4g\n', cell2mat(labels(10)), tev, tevs(1), tevs(2));
fprintf(1,'\n');

%// View 2 outperformance will be greater
%// Canadian Equities will outperform US Equities by 4%
%// Results should match Table 6, Page 23
Q2 = [0.04];
Q = [Q1; Q2];
[Er, ps, w,tt,lambda,theta,tmahal,tmahal_q,tsens,fmahal,fmahal_q,fsens,tev,tevs] = hlblacklitterman(delta, weq, V, tau, P, Q, Omega);
t=[100*Q'; diag(Omega)'/tau; lambda'; theta(1,3:2+size(P,1))];
output(1:n,1)=assets;
output(1:n,2:3)=num2cell(100*P');
output(1:n,4)=num2cell(100*Er);
output(1:n,5)=num2cell(100*w);
change=(w-weq'/(1+tau));
for i=1:n
    if (abs(change(i)) < 1e-10)
        change(i) = 0;
    end
end
output(1:n,6)=num2cell(100*change);
fprintf(1,'\nView 1 & 2, View 2 more bullish (Matches Table 6 in He & Litterman 1999)\n');
fprintf(1,'Country\t\t\t     P\t       mu\t   w*\tw*-weq/(1+tau)\n');
for i=1:n
fprintf(1,'%s\t%6.4g\t%6.4g\t%6.4g\t%6.4g\t%6.4g\n', cell2mat(output(i,1)),cell2mat(output(i,2)),cell2mat(output(i,3)), cell2mat(output(i,4)), cell2mat(output(i,5)),cell2mat(output(i,6)));
end
fprintf(1,'%s\t     %g\t     %g\n',cell2mat(labels(1)),t(1,1),t(1,2));
for i=2:4
fprintf(1,'%s\t     %5.3g\t%5.3g\n',cell2mat(labels(i)),t(i,1),t(i,2));
end
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(5)), theta(1,1));
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(6)), tmahal, tsens(1), tsens(2));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(7)), tmahal_q);
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(8)), fmahal, fsens(1), fsens(2));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(9)), fmahal_q);
fprintf(1,'%s\t     %5.3g\t%5.4g\t%5.4g\n', cell2mat(labels(10)), tev, tevs(1), tevs(2));
fprintf(1,'\n');

%// Decrease confidence in view 1
%// Double the variance of view 1
%// Results should match Table 7, Page 24
Omega(1,1)=2*Omega(1,1);
[Er, ps, w,tt,lambda,theta,tmahal,tmahal_q,tsens,fmahal,fmahal_q,fsens,tev,tevs] = hlblacklitterman(delta, weq, V, tau, P, Q, Omega);
t=[100*Q'; diag(Omega)'/tau; lambda'; theta(1,3:2+size(P,1))];
output(1:n,1)=assets;
output(1:n,2:3)=num2cell(100*P');
output(1:n,4)=num2cell(100*Er);
output(1:n,5)=num2cell(100*w);
change=(w-weq'/(1+tau));
for i=1:n
    if (abs(change(i)) < 1e-10)
        change(i) = 0;
    end
end
output(1:n,6)=num2cell(100*change);
fprintf(1,'\nView 1 & 2, View 1 less confident (Matches Table 7 in He & Litterman 1999)\n');
fprintf(1,'Country\t\t\t     P\t       mu\t   w*\tw*-weq/(1+tau)\n');
for i=1:n
fprintf(1,'%s\t%6.4g\t%6.4g\t%6.4g\t%6.4g\t%6.4g\n', cell2mat(output(i,1)),cell2mat(output(i,2)),cell2mat(output(i,3)), cell2mat(output(i,4)), cell2mat(output(i,5)), cell2mat(output(i,6)));
end
fprintf(1,'%s\t     %g\t     %g\n',cell2mat(labels(1)),t(1,1),t(1,2));
for i=2:4
fprintf(1,'%s\t     %5.3g\t%5.3g\n',cell2mat(labels(i)),t(i,1),t(i,2));
end
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(5)), theta(1,1));
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(6)), tmahal, tsens(1), tsens(2));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(7)), tmahal_q);
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(8)), fmahal, fsens(1), fsens(2));
fprintf(1,'%s\t     %5.4g\n', cell2mat(labels(9)), fmahal_q);
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(10)), tev, tevs(1), tevs(2));
fprintf(1,'\n');

%// Add a new view which matches the results from view 1 & 2 to show it 
%// doesn't change things
P3 = [0.0 1.0 0.0 0.0 -1.0 0.0 0.0 ];
Q3 = [0.0412];
P = [P1; P2; P3];
Q = [Q1; Q2; Q3];
Omega = P * tau * V * P' .* eye(3,3);
Omega(1,1)= 2*Omega(1,1);
[Er, ps, w, tt,lambda,theta,tmahal,tmahal_q,tsens,fmahal,fmahal_q,fsens,tev,tevs] = hlblacklitterman(delta, weq, V, tau, P, Q, Omega);
t=[100*Q'; diag(Omega)'/tau; lambda'; theta(1,3:2+size(P,1))];
output(1:n,1)=assets;
output(1:n,2:4)=num2cell(100*P');
output(1:n,5)=num2cell(100*Er);
output(1:n,6)=num2cell(100*w);
change=(w-weq'/(1+tau));
for i=1:n
    if (abs(change(i)) < 1e-10)
        change(i) = 0;
    end
end
output(1:n,7)=num2cell(100*change);
fprintf(1,'\nView 1, 2& 3, View 1 less confident (Matches Table 8 in He & Litterman 1999)\n');
fprintf(1,'Country\t\t\t       P\t\t       mu\t   w*\tw*-weq/(1+tau)\n');
for i=1:n
fprintf(1,'%s\t%6.4g\t%6.4g\t%6.4g\t%6.4g\t%6.4g\t%6.4g\n', cell2mat(output(i,1)),cell2mat(output(i,2)),cell2mat(output(i,3)), cell2mat(output(i,4)), cell2mat(output(i,5)), cell2mat(output(i,6)), cell2mat(output(i,7)));
end
fprintf(1,'%s\t     %g\t     %g\t     %g\n',cell2mat(labels(1)),t(1,1),t(1,2),t(1,3));
for i=2:4
fprintf(1,'%s\t     %5.3g\t%5.3g\t%5.3g\n',cell2mat(labels(i)),t(i,1),t(i,2),t(i,3));
end
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(5)), theta(1,1));
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(6)), tmahal, tsens(1), tsens(2));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(7)), tmahal_q);
fprintf(1,'%s\t     %5.4g\t%5.4g\t%5.4g\n', cell2mat(labels(8)), fmahal, fsens(1), fsens(2));
fprintf(1,'%s\t     %5.3g\n', cell2mat(labels(9)), fmahal_q);
fprintf(1,'%s\t     %5.3g\t%5.4g\t%5.4g\n', cell2mat(labels(10)), tev, tevs(1), tevs(2));
fprintf(1,'\n');

%//
%// End of hlbl.m