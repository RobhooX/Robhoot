# Download from source

using RemoteFiles
using HTTP
using JSON
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

"Download a file from an API"
function download_api(source::String)
  r = HTTP.request("GET", source; verbose=3);
  println("Status: $(r.status)")
  return String(r.body)
end

"convert a json object to DataFrame"
function json2df(input::Dict)
  cols = reduce(∩, keys.(input["data"]))
  df = DataFrame((Symbol(c)=>getindex.(input["data"], c) for c ∈ cols)...)
  return df
end