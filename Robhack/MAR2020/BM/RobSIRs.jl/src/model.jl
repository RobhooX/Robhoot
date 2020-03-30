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
  I1 < 0 && (I1 = 0.0)
  S1 = node.s * node.R
  S1 < 0 && (S1 = 0.0)
  R1 = node.a * node.I
  R1 < 0 && (R1 = 0.0)
  DS = node.ds * node.S
  DI = node.di * node.I
  DR = node.dr * node.R
  tempS = node.S - I1 + S1 - DS
  tempI = node.I + I1 - R1 - DI
  tempR = node.R + R1 - S1 - DR
  tempS < 0 && (tempS = 0)
  tempI < 0 && (tempI = 0)
  tempR < 0 && (tempR = 0)
  node.D = DS + DI + DR
  node.S, node.I, node.R = tempS, tempI, tempR
end

function get_N(node::Node)
  node.S + node.I + node.R
end

function migrate!(model)
  all_movements = rand.(model[:m])
  for nodeid in 1:model[:C]
    node = model[:nodes][nodeid]
    nodeN = get_N(node)
    if nodeN > 0  # out migration
      n_out = rand.(model[:m][node.id, :])
      partout = sample([:S, :I, :R], weights([node.S, node.I, node.R]))
      for no in 1:model[:C]
        if no != node.id
          n_outn = n_out[no]
          noden = get_N(node)
          n_outn < noden && (n_outn = noden)
          n_outn == 0 && break
          if partout == :S # improve this section
            node.S -= n_outn
            model[:nodes][no].S += n_outn
          elseif partout == :I
            node.I -= n_outn
            model[:nodes][no].I += n_outn
          else
            node.R -= n_outn
            model[:nodes][no].R += n_outn
          end
        end
      end
    end
    n_in = rand.(model[:m][:, node.id])    
    for no in 1:model[:C]
      if no != node.id
        node2 = model[:nodes][no]
        inpart = sample([:S, :I, :R], weights([node2.S, node2.I, node2.R]))
        n_inn = n_in[no]
        noden = get_N(node2)
        n_inn > noden && (n_inn = noden)
        if n_inn > 0
          if inpart == :S
            node.S += n_inn
            model[:nodes][no].S -= n_inn
          elseif inpart == :I
            node.I += n_inn
            model[:nodes][no].I -= n_inn
          else
            node.R += n_inn
            model[:nodes][no].R -= n_inn
          end
        end
      end
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
    end
    migrate!(model)
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

function cases2df(model, cases)
  ccodes, ccols = read_countryCodes()
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