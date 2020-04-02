###
### https://github.com/JuliaWeb/JuliaWebAPI.jl
### https://github.com/beoutbreakprepared/nCoV2019/tree/master/latest_data

data_sources = Dict(
  :covid19Github => ["https://github.com/beoutbreakprepared/nCoV2019/blob/master/latest_data/latestdata.csv", "scv", "api"]
  #:covid19_johnHopkins => ["https://covid2019-api.herokuapp.com/v2/current", "json", "api"],
  #:astros => ["http://api.open-notify.org/astros.json", "json", "api"],
  #:ncov => ["http://data.nextstrain.org/ncov.json", "json", "api"]
)

RobhootDI.download_sources(data_sources, force=false)

dataframes = []
data = readdir(datadir())
for (index, ff) in enumerate(data)
  #if endswith(ff, ".json")
  if endswith(ff, ".csv")
    csvout = csv.read(read(datadir(ff), String))
    #jsonout = JSON3.read(read(datadir(ff), String))
    for k in keys(csvout)#(jsonout)
       if typeof(csvout[k]) <: csv.Array
        df = RobhootDI.csv2df(csvout, k)
        push!(dataframes, df)
      #if typeof(jsonout[k]) <: JSON3.Array
       # df = RobhootDI.json2df(jsonout, k)
        #push!(dataframes, df)
      end
    end
  end
end
