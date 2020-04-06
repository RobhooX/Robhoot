export create_model, agent_step!

mutable struct Pop <: AbstractAgent
  id::Int
  pos::Int
  S::Float64
  I::Float64
  R::Float64
  D::Float64
  b::Float64
  s::Float64
  a::Float64
  ds::Float64
  di::Float64
  dr::Float64
end

function update!(pop::Pop, model)
  I1 = pop.b * pop.I
  I1 > pop.S && (I1 = pop.S)
  S1 = pop.s * pop.R
  S1 > pop.R && (S1 = pop.R)
  R1 = pop.a * pop.I
  R1 > pop.I && (R1 = pop.I)
  DS = pop.ds * pop.S
  DI = pop.di * pop.I
  DR = pop.dr * pop.R
  tempS = pop.S + S1 - I1 - DS
  tempI = pop.I + I1 - R1 - DI
  tempR = pop.R + R1 - S1 - DR
  tempS < 0 && (tempS = 0)
  tempI < 0 && (tempI = 0)
  tempR < 0 && (tempR = 0)
  pop.D = DS + DI + DR
  pop.S, pop.I, pop.R = tempS, tempI, tempR
end

function population_size(pop::Pop)
  pop.S + pop.I + pop.R
end

function migrate!(pop, model)
  nodeN = population_size(pop)
  if nodeN > 0
    relS, relR, relI = pop.S/nodeN, pop.R/nodeN, pop.I/nodeN
    n_out = rand.(model.properties[:m][pop.pos, :])
    partoutS, partoutI, partoutR = (n_out*relS, n_out*relI, n_out*relR)
    # No migrations more than population size at source
    sumpartoutS = sum(partoutS)
    sumpartoutR = sum(partoutR)
    sumpartoutI = sum(partoutI)
    sumpartoutS > pop.S && (partoutS .*= pop.S/sumpartoutS)
    sumpartoutR > pop.R && (partoutR .*= pop.R/sumpartoutR)
    sumpartoutI > pop.I && (partoutI .*= pop.I/sumpartoutI)
    # Migrations
    pop.S -= sumpartoutS
    pop.R -= sumpartoutR
    pop.I -= sumpartoutI
    for (nodeid2, node2) in model.agents
      node2.S += partoutS[node2.pos]
      node2.R += partoutR[node2.pos]
      node2.I += partoutI[node2.pos]        
    end
  end
end

function create_model(;parameters)
  space = Space((parameters[:C], 1))
  model = ABM(Pop, space, properties=parameters)
  for c in 1:parameters[:C]
    pop = Pop(c, c, parameters[:Ss][c], parameters[:Is][c], parameters[:Rs][c], 0, parameters[:bs][c], parameters[:ss][c], parameters[:as][c], parameters[:dss][c], parameters[:dis][c], parameters[:drs][c])
    add_agent!(pop, c, model)
  end
  return model
end

function agent_step!(agent, model)
  update!(agent, model)
  migrate!(agent, model)
end