
data_sources = Dict(
  :covid19_johnHopkins => ["https://covid2019-api.herokuapp.com/v2/current", "json"]
)

for (k, v) in data_sources
  if v[2] == "json"
    data, date = RobhootDI.download_json_api(v[1]);
    # TODO: convert and save
  end
end