
function read_mobility(input="..\\..\\DI\\data\\transformed_data\\mobility.csv")
  m, names = DelimitedFiles.readdlm(input, ',', header=true)
  nrows = size(m, 1)
  mfinal = Float64.(m[1:end, 2:end])
  return mfinal, names[2:end]
end

function read_population(input="..\\..\\DI\\data\\transformed_data\\population.csv")
  m, header = DelimitedFiles.readdlm(input, ',', header=true)
  nrows = size(m, 1)
  mfinal = Float64.(m[1:end, 2])
  names = m[:, 1]
  return mfinal, names
end

function read_cases(input; add2000=true)
  m, names = DelimitedFiles.readdlm(input, ',', header=true)
  nrows = size(m, 1)
  mfinal = Int64.(m[1:end, 2:end])
  countries = m[:, 1]
  names = names[2:end]
  dates = Array{Date}(undef, length(names))
  for (ind, d) in enumerate(names)
    fields = parse.(Int, split(d, "/"))
    year = add2000 ? 2000+fields[3] : fields[3]
    dates[ind] = Date(year, fields[1], fields[2])
  end
  return mfinal, dates, countries
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

function load_params(datadir="..\\..\\DI\\data\\transformed_data")
  mobility, mobnames = RobSIRs.read_mobility(joinpath(datadir, "mobility.csv"))
  pop, popnames = RobSIRs.read_population(joinpath(datadir, "population.csv"))

  mobindices = Int[]
  popindices = Int[]
  for (index, name) in enumerate(popnames)
    mobind = findfirst(x->x==name, mobnames)
    if !isnothing(mobind)
      push!(mobindices, mobind)
      push!(popindices, index)
    end
  end
  
  migration_rates = mobility[mobindices, mobindices]
  # calculate rate: number of travels/pop size
  for n1 in 1:size(migration_rates, 1)
    for n2 in 1:size(migration_rates, 2)
      migration_rates[n1, n2] /= pop[n1]
    end
  end

  Ns = pop[popindices]
  C = length(Ns)
  Ss = Ns
  Ss[1] -= 10
  Is = zeros(Int, C)
  Is[1] += 10
  Rs = zeros(Int, C)
  parameters = Dict(:C=>C, :countries => popnames[popindices], :m => Poisson.(migration_rates), :Ns => Ns, :Ss=>Ss, :Is=>Is, :Rs=>Rs, :bs=>repeat([0.01], C), :cs=>repeat([0.001], C), :ss=>repeat([0.01], C), :as=>rand(C), :dss=>repeat([0.001], C), :dis=>repeat([0.01], C), :drs =>repeat([0.001], C))
  return parameters
end