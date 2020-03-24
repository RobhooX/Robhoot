
data_sources = Dict(
  :covid19_johnHopkins => ["https://covid2019-api.herokuapp.com/v2/current", "json", "api"],
  :astros => ["http://api.open-notify.org/astros.json", "json", "api"]
)

RobhootDI.download_sources(data_sources, force=false)

data = readdir(datadir())
main_entries = [:people, :data]

dataframes = []
for (index, ff) in enumerate(data)
  if endswith(ff, ".json")
    jsonout = JSON3.read(read(datadir(ff), String))
    df = RobhootDI.json2df(jsonout, main_entries[index])
    push!(dataframes, df)
  end
end
