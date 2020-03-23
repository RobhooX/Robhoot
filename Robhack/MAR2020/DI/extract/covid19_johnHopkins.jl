include("download.jl")

function covid19_johnHopkins(source="https://covid2019-api.herokuapp.com/v2/current"; outformat="json")
  string_data = download_api(source);
  jsonout = JSON3.read(string_data)
  if outformat == "df"
    return json2df(jsonout)
  elseif outformat == "json"
    return jsonout
  end
end

covid19 = covid19_johnHopkins(outformat="df");
