
mutable struct Node
  id::Int
  S::Int
  I::Int
  R::Int
  b::Poisson{Float64}
  c::Poisson{Float64}
  s::Poisson{Float64}
  a::Poisson{Float64}
  ds::Poisson{Float64}
  di::Poisson{Float64}
  dr::Poisson{Float64}
end

function update!(node::Node)
  tempS = node.S - (rand(node.b) * rand(node.c) * node.S * node.I) + (rand(node.s) * node.R) - (rand(node.ds) * node.S)
  tempI = node.I + (rand(node.b) * rand(node.c) * node.S * node.I) - (rand(node.a) * node.I) - (rand(node.di) * node.I)
  tempR = node.R + (rand(node.a) * node.I) - (rand(node.s) * node.R) - (rand(node.dr) * node.R)
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

function random_params(;C=3)
  Ns = rand(50:5000, C)
  migration_rates = zeros(C, C);
  for c in 1:C
    for c2 in 1:C
      migration_rates[c, c2] = (Ns[c] + Ns[c2])/Ns[c]
    end
  end
  # normalize migration_rates
  migration_rates_sum = sum(migration_rates, dims=2)
  for c in 1:C
    migration_rates[c, :] ./= migration_rates_sum[c]
  end
  maxM = maximum(migration_rates)
  migration_rates = migration_rates ./ maxM
  migration_rates[diagind(migration_rates)] .= 1.0

  Ss = Ns
  Ss[1] -= 1
  Is = zeros(Int, C)
  Is[1] += 1
  Rs = zeros(Int, C)
  parameters = Dict(:C=>C, :m => Poisson.(migration_rates), :Ns => Ns, :Ss=>Ss, :Is=>Is, :Rs=>Rs, :bs=>rand(C), :cs=>rand(C), :ss=>rand(C), :as=>rand(C), :dss=>rand(0.01:0.01:0.03, C), :dis=>rand(0.01:0.01:0.1, C), :drs =>rand(0.01:0.01:0.03, C))

  return parameters
end

function create_model(;parameters)
  all_nodes = Array{Node}(undef, parameters[:C])
  for c in 1:parameters[:C]
    node = Node(c, parameters[:Ss][c], parameters[:Is][c], parameters[:Rs][c], parameters[:bs][c], parameters[:cs][c], parameters[:ss][c], parameters[:as][c], parameters[:dss][c], parameters[:dis][c], parameters[:drs][c])
    all_nodes[c] = node
  end
  parameters[:all_nodes] = all_nodes
  return parameters
end

parameters = random_params(C=3)
model = create_model(parameters=parameters)

function run!(model, generations = 10)
  for gen in generations
    for n in 1:model[:C]
      node = model[:all_nodes][n]
      update!(node)
      migrate!(node, model)
    end
  end
end