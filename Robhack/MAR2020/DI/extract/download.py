import requests
import grequests
import urllib.request
import os

# Download from source

#!/usr/bin/env python3

#DISCOVER 

#API request ============================================================
#Test :: making request does not work
response = requests.get("http://api.open-notify.org/this-api-doesnt-exist")

#_____________________________________________________________________________________________________________________________________________________
#200: Everything went okay, and the result has been returned (if any).
#301: The server is redirecting you to a different endpoint. This can happen when a company switches domain names, or an endpoint name is changed.
#400: The server thinks you made a bad request. This can happen when you don’t send along the right data, among other things.
#401: The server thinks you’re not authenticated. Many APIs require login credentials, so this happens when you don’t send the right credentials to access an API.
#403: The resource you’re trying to access is forbidden: you don’t have the right permissions to see it.
#404: The resource you tried to access wasn’t found on the server.
#503: The server is not ready to handle the request.
#_____________________________________________________________________________________________________________________________________________________


#Test : making request that work
response = requests.get("http://api.open-notify.org/astros.json")
print(response.status_code)
#200
#------------------------------------------------------------------------


#Option 1
urls = [
    'http://www.heroku.com',
    'http://tablib.org',
    'http://httpbin.org',
    'http://python-requests.org',
    'http://kennethreitz.com'
]

   rs = (grequests.get(u) for u in urls)
   grequests.map(rs)

#Option 2
def main():
# open a connection to a URL using urllib2
   webUrl = urllib2.urlopen("https://www.youtube.com/user/guru99com")
  
#get the result code and print it
   print("result code:" + str(webUrl.getcode())) 
  
# read the data from the URL and print it
   data = webUrl.read()
   print(data)
#==========================================================================



#Making connection to where is the data to the http request below


#EXTRACT 
# http request 
#download data request



urls = ['https://www.gisaid.org/epiflu-applications/next-hcov-19-app/',
        'https://covid2019-api.herokuapp.com/v2/current',
        'https://envidatrepo.wsl.ch/uploads/chelsa/',
        'https://millionneighborhoods.org/#2.45/25.19/23.79',
        'https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-density-rev11'
       ]

#paths=['./data/server'+str(i) for i in range(len(urls))]
paths=['./data/'+'_'.join(urls[i].split('/')[2:]).replace('.','_') for i in range(len(urls))]
def download_file(url,path = './data'):
   """download_file function:

			This function downloads the resource from a server and places it in your local folder.

		Inputs:
			>> url: URL of the desired resource to download.
         >> path (optional): path where the resource will be stored. 
         By default it is stored in the folder ./data/

		Returns:
			<< status: status of the request. 200 is OK.
   

   """
    sread = requests.get(url,allow_redirects=True)
    status = sread.status_code
    if sread:
        print('Success! Downloading...(%s)' % url)
        header = sread.headers
        content_type = header.get('content-type')
        content_type = content_type.replace('application/','')
        fname = '_'.join(url.split('/')[2:]).replace('.','_')
        open(path+'/'+fname+'.'+content_type,'wb+').write(sread.content)
    else:
        print('An error has occurred!')
    return sread.status_code
