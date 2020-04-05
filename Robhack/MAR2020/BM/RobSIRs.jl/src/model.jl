export create_model, agent_step!

mutable struct Pop <: AbstractAgent
  id::Int
  pos::Int  # same as countryID
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

"""
* S = S + sR - b(S) - dsS
* latent = (latent) + b(S) - e(latent) - dlat(latent)
* incubation = (incubation) + e(latent) - i(incubation) - dinc(incubation)
* I = I + i(incubation) - aI - diI
* R = R + aI - sR - drR
"""
function update!(pop::Pop, model::ABM)
  Splus = pop.s * pop.R
  # Splus > pop.R && (Splus = pop.R)
  latentPlus = pop.b * pop.S
  # latentPlus > pop.S && (latentPlus = pop.S)
  incubationPlus = pop.e * pop.latent
  # incubationPlus > pop.latent && (incubationPlus = pop.latent)
  Iplus = pop.i * pop.incubation
  # Iplus > pop.incubation && (Iplus = pop.incubation)
  Rplus = pop.a * pop.I
  # Rplus > pop.I && (Rplus = pop.I)
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
  pop.D = DS + DI + DR
  pop.S, pop.latent, pop.incubation, pop.I, pop.R = tempS, tempLatent, tempIncubation, tempI, tempR
end

function population_size(pop::Pop)
  pop.S + pop.latent + pop.incubation + pop.I + pop.R
end

function migrate!(pop, model)
  nodeN = population_size(pop)
  if nodeN > 0
    relS, relLatent, relIncubation, relR, relI = pop.S/nodeN, pop.latent/nodeN, pop.incubation/nodeN, pop.R/nodeN, pop.I/nodeN
    n_out = rand.(model.properties[:m][pop.pos, :])
    partoutS, partoutLatent, partoutIncubation, partoutI, partoutR = (n_out*relS, n_out*relLatent, n_out*relIncubation, n_out*relI, n_out*relR)
    # No migrations more than population size at source
    sumpartoutS = sum(partoutS)
    sumpartoutLatent = sum(partoutLatent)
    sumpartoutIncubation = sum(partoutIncubation)
    sumpartoutR = sum(partoutR)
    sumpartoutI = sum(partoutI)
    sumpartoutS > pop.S && (partoutS .*= pop.S/sumpartoutS)
    sumpartoutLatent > pop.latent && (partoutLatent .*= pop.latent/sumpartoutLatent)
    sumpartoutIncubation > pop.incubation && (partoutIncubation .*= pop.incubation/sumpartoutIncubation)
    sumpartoutR > pop.R && (partoutR .*= pop.R/sumpartoutR)
    sumpartoutI > pop.I && (partoutI .*= pop.I/sumpartoutI)
    # Migrations
    pop.S -= sumpartoutS
    pop.latent -= sumpartoutLatent
    pop.incubation -= sumpartoutIncubation
    pop.R -= sumpartoutR
    pop.I -= sumpartoutI
    for nodeid2 in 1:nagents(model)
      node2 = model.agents[nodeid2]
      node2.S += partoutS[node2.pos]
      node2.latent += partoutLatent[node2.pos]
      node2.incubation += partoutIncubation[node2.pos]
      node2.R += partoutR[node2.pos]
      node2.I += partoutI[node2.pos]        
    end
  end
end

function agent_step!(pop, model)
  update!(pop, model)
  migrate!(pop, model)
end

function create_model(;parameters)
  space = Space(complete_digraph(parameters[:C]))
  model = ABM(Pop, space, properties=parameters)
  for c in 1:parameters[:C]
    pop = Pop(c, c, 1, parameters[:Ss][c], parameters[:latents][c], parameters[:incubations][c], parameters[:Is][c], parameters[:Rs][c], 0.0, parameters[:bs][c], parameters[:ss][c], parameters[:as][c], parameters[:es][c], parameters[:is][c], parameters[:dss][c], parameters[:dlats][c], parameters[:dincs][c], parameters[:dis][c], parameters[:drs][c])
    add_agent!(pop, model)
  end
  return model
end

function track_cases(model)
  infected = getproperty.(model[:nodes], :I)
  recovered = getproperty.(model[:nodes], :R)
  dead = getproperty.(model[:nodes], :D)

  return infected, recovered, dead
end

function cases2df(model, cases; datadir="..\\..\\DI\\data\\transformed_data")
  ccodes, ccols = read_countryCodes(joinpath(datadir, "countrycodes.csv"))
  ccode_dict = Dict(ccodes[r, 3]=> ccodes[r, 1] for r in 1:size(ccodes, 1))
  countries = [ccode_dict[i] for i in model[:countries]]
  nnodes = length(cases[1][1])
  df = DataFrame(Dict(:location => countries , :infected => cases[1][1], :dead => cases[1][3], :recovered=>cases[1][2], :time => repeat([0], nnodes)))
  for step in 2:length(cases)
    dft = DataFrame(Dict(:location => countries , :infected => cases[step][1], :dead => cases[step][3], :recovered=>cases[step][2], :time => repeat([step-1], nnodes)))
    df = vcat(df, dft)
  end
  return df
end