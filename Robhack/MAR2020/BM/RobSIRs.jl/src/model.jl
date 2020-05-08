export create_model, agent_step!

mutable struct Pop <: AbstractAgent
  id::Int
  pos::Tuple{Int, Int}  # same as countryID
  age_group::Int
  S::Float64  # Susceptible
  latent::Float64
  incubation::Float64
  I::Float64  # Infected
  R::Float64  # Recovered
  D::Float64  # Dead
  b::Float64  # S to latent rate
  s::Float64  # R to S rate
  a::Float64  # I to R rate
  e::Float64  # latent to incubation rate
  i::Float64  # incubation to infected rate
  ds::Float64  # S death rate
  dlat::Float64  # latent death rate
  dinc::Float64  # incubation death rate
  di::Float64  # I death rate
  dr::Float64  # R death rate
end

# TODO: `latentPlus` should include all age groups
"""
* S = S + sR - b(S) - (ds)S
* latent = (latent) + b(S) - e(latent) - (dlat)(latent)
* incubation = (incubation) + e(latent) - i(incubation) - (dinc)(incubation)
* I = I + i(incubation) - aI - (di)I
* R = R + aI - sR - (dr)R
"""
function update!(pop::Pop, model::ABM)
  Splus = pop.s * pop.R
  latentPlus = pop.b * pop.I
  latentPlus > pop.S && (latentPlus = pop.S)
  incubationPlus = pop.e * pop.latent
  Iplus = pop.i * pop.incubation
  Rplus = pop.a * pop.I

  DS = pop.ds * pop.S
  DLatent = pop.dlat * pop.latent
  DIncubation = pop.dinc * pop.incubation
  DI = pop.di * pop.I
  DR = pop.dr * pop.R
  
  tempS = pop.S + Splus - latentPlus - DS
  tempLatent = pop.latent + latentPlus - incubationPlus - DLatent
  tempIncubation = pop.incubation + incubationPlus - Iplus - DIncubation
  tempI = pop.I + Iplus - Rplus - DI
  tempR = pop.R + Rplus - Splus - DR

  tempS < 0 && (tempS = 0)
  tempLatent < 0 && (tempLatent = 0)
  tempIncubation < 0 && (tempIncubation = 0)
  tempI < 0 && (tempI = 0)
  tempR < 0 && (tempR = 0)
  
  pop.D = DS + DLatent + DIncubation + DI + DR
  pop.S, pop.latent, pop.incubation, pop.I, pop.R = tempS, tempLatent, tempIncubation, tempI, tempR
end

population_size(pop::Pop) = pop.S + pop.latent + pop.incubation + pop.I + pop.R

function adjust_fractions!(MFraction, sumMFraction, available)
  if sumMFraction > available 
    (MFraction .*= available/sumMFraction)
    return sumMFraction = sum(MFraction)
  else
    return sumMFraction
  end
end

function migrate!(pop, model)
  nodeN = population_size(pop)
  if nodeN > 0
    relS, relLatent, relIncubation, relR, relI = pop.S/nodeN, pop.latent/nodeN, pop.incubation/nodeN, pop.R/nodeN, pop.I/nodeN
    n_out = rand.(model.m[pop.pos[1], :])
    MFractionS, MFractionLatent, MFractionIncubation, MFractionI, MFractionR = (n_out*relS, n_out*relLatent, n_out*relIncubation, n_out*relI, n_out*relR)
    ## No migrations more than population size at source
    # save summations
    sumMFractionS = sum(MFractionS)
    sumMFractionLatent = sum(MFractionLatent)
    sumMFractionIncubation = sum(MFractionIncubation)
    sumMFractionR = sum(MFractionR)
    sumMFractionI = sum(MFractionI)
    # adjust fractions
    sumMFractionS = adjust_fractions!(MFractionS, sumMFractionS, pop.S)
    sumMFractionLatent = adjust_fractions!(MFractionLatent, sumMFractionLatent, pop.latent)
    sumMFractionIncubation = adjust_fractions!(MFractionIncubation, sumMFractionIncubation, pop.incubation)
    sumMFractionI = adjust_fractions!(MFractionI, sumMFractionI, pop.I)
    sumMFractionR = adjust_fractions!(MFractionR, sumMFractionR, pop.R)
    ## Migrate
    pop.S -= sumMFractionS
    pop.latent -= sumMFractionLatent
    pop.incubation -= sumMFractionIncubation
    pop.R -= sumMFractionR
    pop.I -= sumMFractionI
    for nodeid2 in 1:nagents(model)
      node2 = model[nodeid2]
      node2.S += MFractionS[node2.pos[1]]
      node2.latent += MFractionLatent[node2.pos[1]]
      node2.incubation += MFractionIncubation[node2.pos[1]]
      node2.R += MFractionR[node2.pos[1]]
      node2.I += MFractionI[node2.pos[1]]        
    end
  end
end

function agent_step!(pop, model)  # TODO: change to model_step!
  update!(pop, model)
  migrate!(pop, model)
end

function create_model(;parameters)
  space = GridSpace((parameters[:C], 1))
  model = ABM(Pop, space, properties=parameters)
  for c in 1:parameters[:C]
    pop = Pop(c, (c, 1), 1, parameters[:Ss][c], parameters[:latents][c], parameters[:incubations][c], parameters[:Is][c], parameters[:Rs][c], 0.0, parameters[:bs][c], parameters[:ss][c], parameters[:as][c], parameters[:es][c], parameters[:is][c], parameters[:dss][c], parameters[:dlats][c], parameters[:dincs][c], parameters[:dis][c], parameters[:drs][c])
    add_agent!(pop, c, model)
  end
  return model
end
