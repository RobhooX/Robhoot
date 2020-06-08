using Distributions
srand(321) # Setting the seed for distributions


"""
 hlblacklitterman
   This function performs the Black-Litterman blending of the prior
   and the views into a new posterior estimate of the returns as
   described in the paper by He and Litterman.
 Inputs
   delta  - Risk tolerance from the equilibrium portfolio
   weq    - Weights of the assets in the equilibrium portfolio
   sigma  - Prior covariance matrix
   tau    - Coefficiet of uncertainty in the prior estimate of the mean (pi)
   P      - Pick matrix for the view(s)
   Q      - Vector of view returns
   Omega  - Matrix of variance of the views (diagonal)
 Outputs
   Er     - Posterior estimate of the mean returns
   w      - Unconstrained weights computed given the Posterior estimates
            of the mean and covariance of returns.
   lambda - A measure of the impact of each view on the posterior estimates.
   theta  - A measure of the share of the prior and sample information in the
            posterior precision.
"""
function hlblacklitterman(delta, weq, sigma, tau, P, Q, Omega)
  # Reverse optimize and back out the equilibrium returns
  # This is formula (12) page 6.
  pi1 = weq * sigma * delta;
  # We use tau * sigma many places so just compute it once
  ts = tau * sigma;
  # Compute posterior estimate of the mean
  # This is a simplified version of formula (8) on page 4.
  er = transpose(pi1) + ts * transpose(P) * inv(P * ts * transpose(P) + Omega) * (Q - P * transpose(pi1));
  # Compute posterior estimate of the uncertainty in the mean
  # This is a simplified and combined version of formulas (9) and (15)
  ps = ts - ts * transpose(P) * inv(P * ts * transpose(P) + Omega) * P * ts;
  posteriorSigma = sigma + ps;
  # Compute the share of the posterior precision from prior and views,
  # then for each individual view so we can compare it with lambda
  theta = zeros(1, 2 + size(P, 1));
  theta[1, 1] = (trace(inv(ts) * ps) / size(ts)[1]);
  theta[1, 2] = (trace(transpose(P) * inv(Omega) * P * ps) / size(ts)[1]);
  for i in 1:size(P)[1]
    theta[1, 2+i] = (trace(transpose(P[i,:]) * inv(Omega[i, i]) * P[i,:] * ps) / size(ts)[1]);
  end
  # Compute posterior weights based solely on changed covariance
  w = transpose(transpose(er) * inv(delta * posteriorSigma));
  # Compute posterior weights based on uncertainty in mean and covariance
  pw = transpose(pi1 * inv(delta * posteriorSigma));
  # Compute lambda value
  # We solve for lambda from formula (17) page 7, rather than formula (18)
  # just because it is less to type, and we've already computed w*.
  lambda = transpose(pinv(P)) * transpose(transpose(w) * (1 + tau) - weq);
  # Fusai & Meuccis measure of compatibility between prior and posterior
  n, m = size(ts);
  fmahal = transpose(er-transpose(pi1)) * inv(ts) * (er-transpose(pi1));
  chisq_dist = Chisq(n)
  fmahal_q = 1 - cdf(chisq_dist, fmahal)
  # fmahal_q = 1 - chi2cdf([fmahal], [n]);  # matlab code
  fsens = -2 * pdf(chisq_dist, fmahal) * inv(P * ts * transpose(P) + Omega) * P * (er - transpose(pi1));
  # fsens = -2 * chi2pdf([fmahal], [n]) * inv(P * ts * transpose(P) + Omega) * P * (er - transpose(pi1));  #  Matlab code
  # Theils measure of compatibility between views and the prior
  A = P * ts * transpose(P) + Omega;
  n, m = size(A);
  tmahal = transpose(Q - P * transpose(pi1)) * inv(A) * (Q - P * transpose(pi1));
  tmahal_q = 1 - cdf(chisq_dist, tmahal)
  # tmahal_q = 1 - chi2cdf([tmahal], [n]); # Matlab code
  tsens = -2 * pdf(chisq_dist, tmahal) * (Q - transpose(P * transpose(pi1))) * inv(A)
  # tsens = -2 * chi2pdf([tmahal], [n])*(Q - transpose(P*transpose(pi1))) * inv(A);  # Matlab code
  wactv = transpose( w - weq);
  tev = sqrt(transpose(wactv) * posteriorSigma * (wactv));
  A = P * sigma * transpose(P)/(1+tau) + Omega/tau;
  tevs = transpose(posteriorSigma*wactv/(tev)) * ((1/(1+tau)) * transpose(P) * (((tau/delta)*inv(Omega)) - (inv(A)*(tau/(1+tau))*P*sigma*transpose(P)*inv(Omega)/delta)));

  return er, ps, w, pw, lambda, theta, tmahal, tmahal_q, tsens, fmahal, fmahal_q, fsens, tev, tevs
end