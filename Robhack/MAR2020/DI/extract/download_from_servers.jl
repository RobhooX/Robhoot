include("download.jl")

covid19_johnHopkins = download_json_api("https://covid2019-api.herokuapp.com/v2/current");
covid19_johnHopkins_df = json2df(covid19_johnHopkins)
