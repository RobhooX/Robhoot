#Define functions
#Download from https://juliadynamics.github.io/Agents.jl/stable/examples/sir/

using Agents, Random, DataFrames, LightGraphs
using Distributions: Poisson, DiscreteNonParametric
using DrWatson: @dict
using LinearAlgebra: diagind

mutable struct PoorSoul <: AbstractAgent
  id::Int
  pos::Int
  days_infected::Int  # number of days since is infected
  status::Symbol  # 1: S, 2: I, 3:R
end

function model_initiation(;Ns, migration_rates, β_und, β_det, infection_period =60,
  reinfection_probability = 0.05, detection_time = 14, death_rate = 0.1,
  Is=[zeros(Int, length(Ns)-1)..., 1], seed = 0)

  Random.seed!(seed)
  @assert length(Ns) == length(Is) == length(β_und) == length(β_det) == size(migration_rates, 1) "length of Ns, Is, and B, and number of rows/columns in migration_rates should be the same "
  @assert size(migration_rates, 1) == size(migration_rates, 2) "migration_rates rates should be a square matrix"

  C = length(Ns)
  # normalize migration_rates
  migration_rates_sum = sum(migration_rates, dims=2)
  for c in 1:C
    migration_rates[c, :] ./= migration_rates_sum[c]
  end

  properties =
    @dict(Ns, Is, β_und, β_det, β_det, migration_rates, infection_period,
    infection_period, reinfection_probability, detection_time, C, death_rate)
  space = GraphSpace(complete_digraph(C))
  model = ABM(PoorSoul, space; properties=properties)

  # Add initial individuals
  for city in 1:C, n in 1:Ns[city]
    ind = add_agent!(city, model, 0, :S) # Susceptible
  end
  # add infected individuals
  for city in 1:C
    inds = get_node_contents(city, model)
    for n in 1:Is[city]
      agent = id2agent(inds[n], model)
      agent.status = :I # Infected
      agent.days_infected = 1
    end
  end
  return model
end

#Second 
function create_params(;C, max_travel_rate, infection_period = 30,
    reinfection_probability = 0.05, detection_time = 14, death_rate = 0.02,
    Is=[zeros(Int, C-1)..., 1], seed = 19
  )

  Random.seed!(seed)
  Ns = rand(50:5000, C)
  β_und = rand(0.3:0.02:0.6, C)
  β_det = β_und ./ 10

  Random.seed!(seed)
  migration_rates = zeros(C, C);
  for c in 1:C
    for c2 in 1:C
      migration_rates[c, c2] = (Ns[c] + Ns[c2])/Ns[c]
    end
  end
  maxM = maximum(migration_rates)
  migration_rates = (migration_rates .* max_travel_rate) ./ maxM
  migration_rates[diagind(migration_rates)] .= 1.0

  params = @dict(Ns, β_und, β_det, migration_rates, infection_period,
    reinfection_probability, detection_time, death_rate, Is)

  return params
end

function agent_step!(agent, model)
  migrate!(agent, model)
  transmit!(agent, model)
  update!(agent, model)
  recover_or_die!(agent, model)
end

function migrate!(agent, model)
  nodeid = agent.pos
  d = DiscreteNonParametric(1:model.properties[:C], model.properties[:migration_rates][nodeid, :])
  m = rand(d)
  if m ≠ nodeid
    move_agent!(agent, m, model)
  end
end

function transmit!(agent, model)
  agent.status == :S && return
  prop = model.properties
  rate = if agent.days_infected < prop[:detection_time]
    prop[:β_und][agent.pos]
  else
    prop[:β_det][agent.pos]
  end

  d = Poisson(rate)
  n = rand(d)
  n == 0 && return

  for contactID in get_node_contents(agent, model)
    contact = id2agent(contactID, model)
    if contact.status == :S || (contact.status == :R && rand() ≤ prop[:reinfection_probability])
      contact.status = :I
      n -= 1
      n == 0 && return
    end
  end
end

update!(agent, model) = agent.status == :I && (agent.days_infected += 1)

function recover_or_die!(agent, model)
  if agent.days_infected ≥ model.properties[:infection_period]
    if rand() ≤ model.properties[:death_rate]
      kill_agent!(agent, model)
    else
      agent.status = :R
      agent.days_infected = 0
    end
  end
end

infected(x) = count(i == :I for i in x)
recovered(x) = count(i == :R for i in x)
