
function create_dicts(space=[6, 10])
  nsites = prod(space)

  food_df = CSV.File("food_source.csv") |> DataFrame
  foodsource = vec(Float64.(Matrix(food_df[:, 2:end])))
  interactions_df = CSV.File("interactions.csv") |> DataFrame
  interactions = vec(Float64.(Matrix(food_df[:, 2:end])))
  model_parameters = Dict(
    "generations" => 100,  # number of simulation steps
    "space" => space,  # size of grid (rows, columns)
    "metric" => "chebyshev",
    "periodic" => false,  # whether boundaries of the space are connected
    "resources" => rand(4000:7000, nsites),  # available resources per site per time
    "interactions" => interactions,
    "food sources" => foodsource,
    "seed" => nothing
  )

  species_parameters_common = Dict(
    "number of genes" => 2,
    "number of phenotypes" => 2,
    "abiotic phenotypes" => [1],
    "biotic phenotypes" => [1],
    "migration phenotype" => 2,
    "migration threshold" => 3.5,
    "vision radius" => 1,
    "check fraction" => 0.5,
    "ploidy" => 2,
    "epistasis matrix" => [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    "pleiotropy matrix" => [1, 0, 0, 1, 1, 0, 0, 1],
    "growth rate" => 1.2,
    "expression array" => [0.288, 0.462, 0.260, 0.952],
    "selection coefficient" => 0.5,
    "mutation probabilities" => [0.9, 0.0, 0.0],
    "mutation magnitudes" => [0.05, 0.0, 0.0],
    "environmental noise" => 0.01,
    "optimal phenotypes" => fill(1, model_parameters["generations"] + 1),
    "age" => 5,
    "recombination" => 1,
    "initial energy" => 1,
    "reproduction start age" => 1,
    "reproduction end age" => 5,
    "bottleneck function" => "bottleneck.jl",
    "bottleneck times" => fill(0, model_parameters["generations"] * nsites)
  )


  species_parameters = Dict(
    1 => Dict("name" => "Platichthys flesus", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    2 => Dict("name" => "Aphia minuta", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    3 => Dict("name" => "Chelidonichthys cuculus", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    4 => Dict("name" => "Dicentrarchus labrax", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    5 => Dict("name" => "Scophthalmus rhombus", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    6 => Dict("name" => "Trachinus draco", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    7 => Dict("name" => "Hippoglossoides platessoides", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    8 => Dict("name" => "Lumpenus lampretaeformis", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    9 => Dict("name" => "Lycodes vahlii", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    10 => Dict("name" => "Enchelyopus cimbrius", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    11 => Dict("name" => "Lycenchelys sarsii", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)]),
    12 => Dict("name" => "Glyptocephalus cynoglossus", "expression array" => rand(2, 2), "N" =>rand(10:100, nsites), "optimal phenotype values" => [rand(nsites)])
  )

  for (k, v) in species_parameters
    for (k2, v2) in species_parameters_common
      species_parameters[k][k2] = v2 
    end
  end

  data = data = Dict("species"=> species_parameters, "model"=> model_parameters)

  return data
end