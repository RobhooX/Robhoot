# Download from source

using RemoteFiles
using HTTP

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
function download_api(source::String, datadir::String="./")
  r = HTTP.request("GET", source; verbose=3);
  r.status == 200 && (println("Connected successfully."))
  
end