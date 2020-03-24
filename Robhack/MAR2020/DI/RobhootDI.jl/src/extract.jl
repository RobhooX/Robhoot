# Download from source

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

function download_sources(data_sources::Dict; force=false)
  for (k, v) in data_sources
    if v[2] == "json" 
      if v[3] == "api"
        string_data = RobhootDI.download_api(v[1]);
        outfile = datadir("$(string(k)).json")
        if !isfile(outfile) || (isfile(outfile) && force == true)
          print(open(outfile, "w"), string_data);
        end
      elseif v[3] == "file"
        RobhootDI.download_file(v[1], datadir("$(string(k)).json"))
      end
    end
  end
end