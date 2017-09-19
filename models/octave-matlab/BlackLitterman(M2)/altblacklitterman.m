%// Black-Litterman example code for MatLab (hlblacklitterman.m)
%// Copyright (c) Jay Walters, blacklitterman.org, 2008.
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

%// altblacklitterman
%//   This function performs the Black-Litterman blending of the prior
%//   and the views into a new posterior estimate of the returns using
%//   the alternatie reference model (no posterior variance) as
%//   described in the paper Meucci and others.
%// Inputs
%//   delta  - Risk tolerance from the equilibrium portfolio
%//   weq    - Weights of the assets in the equilibrium portfolio
%//   sigma  - Prior covariance matrix
%//   P      - Pick matrix for the view(s)
%//   Q      - Vector of view returns
%//   Omega  - Matrix of variance of the views (diagonal)
%// Outputs
%//   Er     - Posterior estimate of the mean returns
%//   w      - Unconstrained weights computed given the Posterior estimates
%//            of the mean and covariance of returns.
%//   lambda - A measure of the impact of each view on the posterior estimates.
%//
function [er, w, lambda] = altblacklitterman(delta, weq, sigma, P, Q, Omega)
  %// Reverse optimize and back out the equilibrium returns
  %// This is formula (12) page 6.
  pi = weq * sigma * delta;
  %// Compute posterior estimate of the mean
  %// This is a simplified version of formula (8) on page 4.
  er = pi' + sigma * P' * inv(P * sigma * P' + Omega) * (Q - P * pi');
  %// Compute posterior weights based on uncertainty in mean
  w = (er' * inv(delta * sigma))';
  %// Compute lambda
  %// lambda = pinv(P)' * (w' - weq)';  We can back out lambda
  %// But we actually want to really calculate it here
  A = P' * inv(Omega) * P * sigma;
  B = eye(size(sigma,1)) + A;
  lambda = pinv(P)' * (1/delta) * (-(inv(B)*P'*inv(Omega)*P*pi') + (inv(B)*P'*inv(Omega)*Q));
end
