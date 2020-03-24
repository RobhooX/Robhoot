import requests
import grequests
import urllib.request

# Download from source

#!/usr/bin/env python3

<<<<<<< HEAD
#DISCOVER 

#API request ============================================================
=======

# DISCOVER
#Automated list of (long repo) servers and API  request
#for i = 1:S; #Servers

#-------------------------------------------------------------------------
>>>>>>> 3fb2865ff33a684e606675bb9c6f0ef01121a6f7
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


<<<<<<< HEAD
#EXTRACT 
# http request 
=======
# EXTRACTION : HTTP request 

>>>>>>> 3fb2865ff33a684e606675bb9c6f0ef01121a6f7
#download data request



urls=['http://api.open-notify.org/astros.json','https://covid2019-api.herokuapp.com/v2/current','https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/documentos/Actualizacion_53_COVID-19.pdf']
paths=['./data/server'+str(i) for i in range(len(urls))]
def download_file(url,path):
    sread=requests.get(url,allow_redirects=True)
    header=sread.headers
<<<<<<< HEAD
    content_type = header.get('content-type')
    content_type=content_type.replace('application/','')
    open(path+'.'+content_type,'wb+').write(sread.content)

for url,path in zip(urls,paths):
    download_file(url,path)

#map(download_file,urls,paths)


 #TRANSFORM
  
 
 # LOAD   
=======
    content_type=header.get('content-type')
    open(path+'.'+content_type,'wb').write(sread.content)


# TRANSFORMATION
#Converting list with many formats to tables
#Table format SQL or other (Julia :: Clickhouse)

# LOAD
#

>>>>>>> 3fb2865ff33a684e606675bb9c6f0ef01121a6f7
