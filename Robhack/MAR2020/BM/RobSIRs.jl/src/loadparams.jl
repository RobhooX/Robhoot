
function read_countryCodes(input="..\\..\\DI\\data\\transformed_data\\countrycodes.csv")
  m, names = DelimitedFiles.readdlm(input, ',', header=true)
  return m, names
end

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
  parameters = Dict(:C=>C, :m => Poisson.(migration_rates), :Ns => Ns, :Ss=>Ss, :Is=>Is, :Rs=>Rs, :bs=>repeat([1.6], C), :ss=>repeat([0.01], C), :as=>rand(C), :dss=>repeat([0.001], C), :dis=>repeat([0.01], C), :drs =>repeat([0.001], C))

  return parameters
end

function load_data(datadir)
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
      migration_rates[n1, n2] /= (pop[n1] * 365)
      migration_rates[n1, n2] > 1 && (migration_rates[n1, n2] = 0.99)
    end
  end
  return pop, popnames, mobindices, popindices, migration_rates
end

function load_params(;age_groups=10, bs=0.0:0.0001:1.0, ss=0.01:0.0001:1.0, as= 0.01:0.0001:1.0, es=0.01:0.0001:1.0, is=0.01:0.0001:1.0, dss=0.0:0.0001:1.0, dlats=0.0:0.0001:1.0, dincs=0.0:0.0001:1.0, dis=0.001:0.0001:1.0, drs=0.0:0.0001:1.0,
  datadir="..\\..\\DI\\data\\transformed_data")

  pop, popnames, mobindices, popindices, migration_rates = load_data(datadir)
  Ns = pop[popindices]
  C = length(Ns)
  age_fractions = [rand(age_groups) for i in 1:C]
  for af in 1:C
    age_fractions[af] = age_fractions[af] ./ sum(age_fractions[af])
  end
  Ss = Ns .* age_fractions
  chinaindex = findfirst(x->x=="CHN",  popnames[popindices])
  Ss[chinaindex][1] -= 10.0
  latents = zeros(Float64, C, age_groups)
  incubations = zeros(Float64, C, age_groups)
  Is = zeros(Float64, C, age_groups)
  Is[chinaindex, 1] += 10.0
  Rs = zeros(Float64, C, age_groups)
  popmat = zeros(Int64, C, C)
  for c1 in 1:C
    for c2 in 1:C
      popmat[c1, c2] = round(Int, Ns[c1])
    end
  end
  parameters = Dict(:C=>C, :countries => popnames[popindices], :m => Binomial.(popmat, migration_rates), :Ns => Ns, :Ss=>Ss, :latents => latents, :incubations => incubations, :Is=>Is, :Rs=>Rs,
  :bs=>rand(bs, C, age_groups, age_groups),  # bs_{hij} means b parameter of age group i on age group j in region h. 
  :ss=>rand(ss, C, age_groups),
  :as=>rand(as, C, age_groups),
  :es => rand(es, C, age_groups),
  :is => rand(is, C, age_groups),
  :dss=>rand(dss, C, age_groups),
  :dis=>rand(dis, C, age_groups),
  :drs =>rand(drs, C, age_groups),
  :dlats => rand(dlats, C, age_groups),
  :dincs => rand(dincs, C, age_groups),
  :age_groups => age_groups)
  return parameters
end
