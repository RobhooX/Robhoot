# Download from source

using RemoteFiles
using HTTP
using JSON3
using DataFrames

"Download a file from a URL"
function download_file(datafile::String, datadir::String="./"; overwrite=false)
  @RemoteFile(filename, datafile, dir=datadir)

  if !isfile(filename) || overwrite
    println("Downloading...")
    download(filename)
  end
  filepath = path(filename)

  return filepath
end

"Download a file from an API URL"
function download_api(source::String)
  r = HTTP.request("GET", source; verbose=3);
  println("Status: $(r.status)")
  return String(r.body)
end

"convert a json object to DataFrame"
function json2df(input)
  cols = reduce(∩, keys.(input["data"]))
  df = DataFrame((Symbol(c)=>getindex.(input["data"], c) for c ∈ cols)...)
  return df
end

"Download data in JSON format from API url"
function download_json_api(source)
  string_data = download_api(source);
  jsonout = JSON3.read(string_data)
end