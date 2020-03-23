# Download from source

#!/usr/bin/env python3
#http request 


import requests as req

resp = req.request(method='GET', url="http://example")
print(resp.text)





using RemoteFiles

"Downloads all dbVar data from a source"
function download_data(datafile, datadir; overwrite=false)
  @RemoteFile(filename, datafile, dir=datadir)

  if !isfile(filename) || overwrite
    println("Downloading data. This can take a few minutes.")
    download(filename)
  end
  filepath = path(filename)

  return filepath
end