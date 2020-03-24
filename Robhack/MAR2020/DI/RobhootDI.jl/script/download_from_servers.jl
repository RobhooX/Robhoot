
data_sources = Dict(
  :covid19_johnHopkins => ["https://covid2019-api.herokuapp.com/v2/current", "json", "api"],
  :astros => ["http://api.open-notify.org/astros.json", "json", "api"]
)

RobhootDI.download_sources(data_sources, force=false)

dataframes = []
data = readdir(datadir())
for (index, ff) in enumerate(data)
  if endswith(ff, ".json")
    jsonout = JSON3.read(read(datadir(ff), String))
    for k in keys(jsonout)
      if typeof(jsonout[k]) <: JSON3.Array
        df = RobhootDI.json2df(jsonout, k)
        push!(dataframes, df)
      end
    end
  end
end
