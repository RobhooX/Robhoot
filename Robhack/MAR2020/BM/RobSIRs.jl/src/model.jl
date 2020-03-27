
mutable struct Node
  id::Int
  S::Int
  I::Int
  R::Int
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
  tempS = node.S - I1 + S1 - round(Int, node.ds * node.S)
  tempI = node.I + I1 - R1 - round(Int, node.di * node.I)
  tempR = node.R + R1 - S1 - round(Int, node.dr * node.R)
  tempS < 0 && (tempS = 0)
  tempI < 0 && (tempI = 0)
  tempR < 0 && (tempR = 0)
  node.S, node.I, node.R = tempS, tempI, tempR
end

function migrate!(node::Node, model)
  n_out = rand.(model[:m][node.id, :])
  n_in = rand.(model[:m][:, node.id])
  outs = sample(n_out, weights([node.S, node.I, node.R]), 3)
  ins = sample(n_in, weights([node.S, node.I, node.R]), 3)
  node.S, node.I, node.R = (node.S, node.I, node.R) .- outs
  node.S, node.I, node.R = (node.S, node.I, node.R) .+ outs
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
  parameters = Dict(:C=>C, :m => Poisson.(migration_rates), :Ns => Ns, :Ss=>Ss, :Is=>Is, :Rs=>Rs, :bs=>rand(C), :cs=>repeat([0.001], C), :ss=>rand(C), :as=>rand(C), :dss=>repeat([0.001], C), :dis=>repeat([0.01], C), :drs =>repeat([0.001], C))

  return parameters
end

function create_model(;parameters)
  all_nodes = Array{Node}(undef, parameters[:C])
  for c in 1:parameters[:C]
    node = Node(c, parameters[:Ss][c], parameters[:Is][c], parameters[:Rs][c], parameters[:bs][c], parameters[:cs][c], parameters[:ss][c], parameters[:as][c], parameters[:dss][c], parameters[:dis][c], parameters[:drs][c])
    all_nodes[c] = node
  end
  parameters[:nodes] = all_nodes
  return parameters
end

parameters = random_params(C=3);
model = create_model(parameters=parameters)

function step!(model, nsteps = 10)
  infected = Array{Int}(undef, nsteps+1)
  infected[1] = ninfected(model)
  for gen in nsteps
    for n in 1:model[:C]
      node = model[:all_nodes][n]
      update!(node)
      migrate!(node, model)
      infected[gen+1] = ninfected(model)
    end
  end
end

function ninfected(model)
  infected = 0
  for node in model[:nodes]
    infected += node.I
  end
  return infected  
end