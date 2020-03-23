
# Download from source

#!/usr/bin/env python3


# DISCOVER
#Automated list of (long repo) servers and API  request
#for i = 1:S; #Servers

#-------------------------------------------------------------------------
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


#Making connection to where is the data to the http request below


# EXTRACTION : HTTP request 

#download data request
import requests



urls=['a','b']
paths=['./data/server'+str(i) for i in range(len(urls))]
for i in range(len(urls)):
    url=urls[i]
    path=paths[i]
    sread=requests.get(url,allow_redirects=True)
    header=sread.headers
    content_type=header.get('content-type')
    open(path+'.'+content_type,'wb').write(sread.content)


# TRANSFORMATION
#Converting list with many formats to tables
#Table format SQL or other (Julia :: Clickhouse)

# LOAD
#

