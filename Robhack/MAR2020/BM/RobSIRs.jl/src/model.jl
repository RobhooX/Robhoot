
mutable struct Node
  id::Int
  S::Int
  I::Int
  R::Int
  D::Int
  b::Float64
  c::Float64
  s::Float64
  a::Float64
  ds::Float64
  di::Float64
  dr::Float64
end

function update!(node::Node)
  I1 = round(Int, node.b * node.c * node.S * node.I)
  S1 = round(Int, node.s * node.R)
  R1 = round(Int, node.a * node.I)
  DS = round(Int, node.ds * node.S)
  DI = round(Int, node.di * node.I)
  DR = round(Int, node.dr * node.R)
  tempS = node.S - I1 + S1 - DS
  tempI = node.I + I1 - R1 - DI
  tempR = node.R + R1 - S1 - DR
  tempS < 0 && (tempS = 0)
  tempI < 0 && (tempI = 0)
  tempR < 0 && (tempR = 0)
  node.D = DS + DI + DR
  node.S, node.I, node.R = tempS, tempI, tempR
end

function migrate!(model)
  all_movements = rand.(model[:m])
  for nodeid in 1:model[:C]
    node = model[:nodes][nodeid]
    n_out = rand.(model[:m][node.id, :])
    partout = sample([:S, :I, :R], weights([node.S, node.I, node.R]))
    for no in 1:model[:C]
      if no != node.id
        if partout == :S # improve this section
          node.S -= n_out[no]
          model[:nodes][no].S += n_out[no]
        elseif partout == :I
          node.I -= n_out[no]
          model[:nodes][no].I += n_out[no]
        else
          node.R -= n_out[no]
          model[:nodes][no].R += n_out[no]
        end
      end
    end
    n_in = rand.(model[:m][:, node.id])    
    for no in 1:model[:C]
      if no != node.id
        node2 = model[:nodes][no]
        inpart = sample([:S, :I, :R], weights([node2.S, node2.I, node2.R]))
        if inpart == :S
          node.S += n_in[no]
          model[:nodes][no].S -= n_in[no]
        elseif inpart == :I
          node.I += n_in[no]
          model[:nodes][no].I -= n_in[no]
        else
          node.R += n_in[no]
          model[:nodes][no].R -= n_in[no]
        end
      end
    end
  end
end

function random_params(;C=200)
  Ns = rand(500_000:2_000_000, C)
  migration_rates = rand(0.01:0.01:0.02, C, C)
  migration_rates[diagind(migration_rates)] .= 0.98

  Ss = Ns
  Ss[1] -= 10
  Is = zeros(Int, C)
  Is[1] += 10
  Rs = zeros(Int, C)
  parameters = Dict(:C=>C, :m => Poisson.(migration_rates), :Ns => Ns, :Ss=>Ss, :Is=>Is, :Rs=>Rs, :bs=>repeat([0.01], C), :cs=>repeat([0.001], C), :ss=>repeat([0.01], C), :as=>rand(C), :dss=>repeat([0.001], C), :dis=>repeat([0.01], C), :drs =>repeat([0.001], C))

  return parameters
end

function create_model(;parameters)
  all_nodes = Array{Node}(undef, parameters[:C])
  for c in 1:parameters[:C]
    node = Node(c, parameters[:Ss][c], parameters[:Is][c], parameters[:Rs][c], 0, parameters[:bs][c], parameters[:cs][c], parameters[:ss][c], parameters[:as][c], parameters[:dss][c], parameters[:dis][c], parameters[:drs][c])
    all_nodes[c] = node
  end
  parameters[:nodes] = all_nodes
  return parameters
end

function step!(model, nsteps = 10)
  infected = Array{Int}(undef, nsteps+1)
  infected[1] = ninfected(model)
  for gen in nsteps
    for n in 1:model[:C]
      node = model[:nodes][n]
      update!(node)
    end
    migrate!(model)
    infected[gen+1] = ninfected(model)
  end
  return model, infected
end

function ninfected(model)
  infected = 0
  for node in model[:nodes]
    infected += node.I
  end
  return infected  
end
