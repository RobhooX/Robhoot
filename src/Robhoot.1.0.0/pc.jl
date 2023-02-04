using CausalInference
using LightGraphs
include("plotdag.jl")

# Generate some data

N = 1000
p = 0.01
x = randn(N)
v = x + randn(N)*0.25
w = x + randn(N)*0.25
z = v + w + randn(N)*0.25
s = z + randn(N)*0.25

df = (x=x, v=v, w=w, z=z, s=s)

println("Running Gaussian tests")
@time est_g = pcalg(df, p, gausscitest)

variables = [String(k) for k in keys(df)]
tp = plot_dag(est_g, variables)
save(PDF("estdag"), tp)
