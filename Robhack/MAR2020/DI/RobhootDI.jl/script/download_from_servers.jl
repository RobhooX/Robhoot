
data_sources = Dict(
  :covid19_johnHopkins => ["https://covid2019-api.herokuapp.com/v2/current", "json", "api"],
  :astros => ["http://api.open-notify.org/astros.json", "json", "api"]
)

for (k, v) in data_sources
  if v[2] == "json" 
    if v[3] == "api"
      data, date = RobhootDI.download_json_api(v[1]);
      # TODO: convert and save
    elseif v[3] == "file"
      data, date = RobhootDI.download_json_file(v[1], datadir())
    end
  end
end