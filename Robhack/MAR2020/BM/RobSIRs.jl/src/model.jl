
mutable struct Node
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
  tempS = node.S - node.b * node.c * node.S * node.I + node.s * node.R - node.ds * node.S
  tempI = node.I + node.b * node.c * model.S * model.I - model.a * model.I - model.di * node.I
  tempR = node.R + (node.a * node.I) - (s * node.R) - (node.dr * node.R)
end