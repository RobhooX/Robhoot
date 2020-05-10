export create_model, model_step!

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
  # b::Float64  # S to latent rate
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

"""
`latentPlus` is how many new individuals get the virus as a function of all age groups.

# Equations:

* S = S + sR - b(S) - (ds)S
* latent = (latent) + latentPlus - e(latent) - (dlat)(latent)
* incubation = (incubation) + e(latent) - i(incubation) - (dinc)(incubation)
* I = I + i(incubation) - aI - (di)I
* R = R + aI - sR - (dr)R
"""
function update!(pop::Pop, model::ABM, latentPlus)
  Splus = pop.s * pop.R
  # latentPlus = pop.b * pop.I
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

"Update each population by including the number of new infections in each age group as a function of all age groups"
function update!(model::ABM)
  for (id, pop) in model.agents
    region = pop.pos
    bs = model.bs[region[1], :, :]
    other_ages = get_node_contents(region, model)
    popindex = findfirst(x-> x==pop.id, other_ages)
    latentPlus = 0.0
    for (index, agid) in enumerate(other_ages)
      latentPlus +=  bs[index, popindex] * model.agents[agid].I
    end
    update!(pop, model, latentPlus)
  end
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

function model_step!(model)
  update!(model)
  for pop in values(model.agents)
    migrate!(pop, model)
  end
end

function create_model(;parameters)
  space = GridSpace((parameters[:C], 1))
  model = ABM(Pop, space, properties=parameters)
  id = 1
  for c in 1:parameters[:C]
    for age_group in 1:parameters[:age_groups]
      pop = Pop(id, (c, 1), age_group, parameters[:Ss][c][age_group], parameters[:latents][c, age_group], parameters[:incubations][c, age_group], parameters[:Is][c, age_group], parameters[:Rs][c, age_group], 0.0, parameters[:ss][c, age_group], parameters[:as][c, age_group], parameters[:es][c, age_group], parameters[:is][c, age_group], parameters[:dss][c, age_group], parameters[:dlats][c, age_group], parameters[:dincs][c, age_group], parameters[:dis][c, age_group], parameters[:drs][c, age_group])
      add_agent!(pop, c, model)
      id += 1
    end
  end
  return model
end
