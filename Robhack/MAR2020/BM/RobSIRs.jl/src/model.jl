export step!, create_model

mutable struct Node
  id::Int
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

function update!(node::Node)
  I1 = node.b * node.I
  I1 > node.S && (I1 = node.S)
  S1 = node.s * node.R
  S1 > node.R && (S1 = node.R)
  R1 = node.a * node.I
  R1 > node.I && (R1 = node.I)
  DS = node.ds * node.S
  DI = node.di * node.I
  DR = node.dr * node.R
  tempS = node.S + S1 - I1 - DS
  tempI = node.I + I1 - R1 - DI
  tempR = node.R + R1 - S1 - DR
  tempS < 0 && (tempS = 0)
  tempI < 0 && (tempI = 0)
  tempR < 0 && (tempR = 0)
  node.D = DS + DI + DR
  node.S, node.I, node.R = tempS, tempI, tempR
end

function population_size(node::Node)
  node.S + node.I + node.R
end

function migrate!(node, model)
  nodeN = population_size(node)
  if nodeN > 0
    relS, relR, relI = node.S/nodeN, node.R/nodeN, node.I/nodeN
    n_out = rand.(model[:m][node.id, :])
    partoutS, partoutI, partoutR = (n_out*relS, n_out*relI, n_out*relR)
    # No migrations more than population size at source
    sumpartoutS = sum(partoutS)
    sumpartoutR = sum(partoutR)
    sumpartoutI = sum(partoutI)
    sumpartoutS > node.S && (partoutS .*= node.S/sumpartoutS)
    sumpartoutR > node.R && (partoutR .*= node.R/sumpartoutR)
    sumpartoutI > node.I && (partoutI .*= node.I/sumpartoutI)
    # Migrations
    node.S -= sumpartoutS
    node.R -= sumpartoutR
    node.I -= sumpartoutI
    for (nodeid2, node2) in enumerate(model[:nodes])
      node2.S += partoutS[nodeid2]
      node2.R += partoutR[nodeid2]
      node2.I += partoutI[nodeid2]        
    end
  end
end

function create_model(;parameters)
  all_nodes = Array{Node}(undef, parameters[:C])
  for c in 1:parameters[:C]
    node = Node(c, parameters[:Ss][c], parameters[:Is][c], parameters[:Rs][c], 0, parameters[:bs][c], parameters[:ss][c], parameters[:as][c], parameters[:dss][c], parameters[:dis][c], parameters[:drs][c])
    all_nodes[c] = node
  end
  parameters[:nodes] = all_nodes
  return parameters
end

function step!(model, nsteps = 10)
  cases = Array{Tuple}(undef, nsteps+1)
  cases[1] = track_cases(model)
  for gen in 2:nsteps+1
    for n in 1:model[:C]
      update!(model[:nodes][n])
      migrate!(model[:nodes][n], model)
    end
    cases[gen] = track_cases(model)
  end
  return model, cases
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