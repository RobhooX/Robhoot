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

import os
import requests
from mimetypes import guess_extension
def download_file(url,path = './data'):
    """
    download_file function:

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
        ext = guess_extension(sread.headers['content-type'].partition(';')[0].strip())
        #HERE WE NEED TO CHECK IF IT IS AN HTML/HTM TO CHECK THE LINKS INSIDE AND SEE IF IT IS A RESOURCE OR NOT
        if ext in ['html', 'htm']:
            # get links as urls2
            for urls in urls2:
                download_file(url)
        else:        
            fname = '_'.join(url.split('/')[2:]).replace('.','_')+ext
            pathFname = path + '/' + fname
            # Check if directory at path exists and create it if it does not exist
            if not os.path.exists(path):
                os.makedirs(path)
            # TO DO (NOT OVERWRITE DATA WITH POTENTIALLY DIFFERENT DATA FROM THE SAME URL THAT COULD BE UPDATED)
            # Here we would need a pipeline to update/save the data so that we do not overwrite data already downloaded
            #elif os.path.isfile(pathFname):
                #fname = '_'.join(url.split('/')[2:]).replace('.','_')+'0'+ext
                #pathFname = path + '/' + fname
            print('Saving in '+pathFname)
            open(pathFname,'wb+').write(sread.content)
    else:
        print('An error has occurred with status code %i' % status)
    return status

for url in urls:
    download_file(url)   

 

 ###### CODE FOR ENVIRONMENTAL DATA, DIRECTORY

from bs4 import BeautifulSoup,SoupStrainer
url='https://envidatrepo.wsl.ch/uploads/chelsa/'

#### Return [False,[]] if it is not html
#### Return [True,[list of links]] if it is html

def getlinks(sread):
    """
    getlinks function:

        This function gets the links that can be found in the url to which the request sred is a response.

    Inputs:

        >> sread: Response of a request

    Outputs:

        << links: List of links inside that url

    """
    links=[]
    for link in BeautifulSoup(sread.content, "html.parser", parse_only=SoupStrainer('a', href=True)):
        links.append(link['href'])
#      for link in soup.findAll('a', attrs = {'href': re.compile("^http://")}):
#        links.append(link.get('href'))
    return links

def check_html(url):
    """
    check_html function:

        This function checks if the url points to an html document and asks for the links inside if it is true.

    Inputs:

        >> url: url that we want to check

    Outputs:

        << l: list with 2 entries. The first is a Boolean variable 
                l[0] = False, not html and l[1] = []
                l[1] = True, html and l[1] = list of links inside that url

    """
    sread = requests.get(url,allow_redirects=True)
    ext = guess_extension(sread.headers['content-type'].partition(';')[0].strip())
    if ext not in ['.html', '.htm']:
        return([False,[]])
    else:
        return([True,getlinks(sread)])



max_depth = 5 ###Maximum depth we will look from the parent directory
dout = [[] for i in range(max_depth+1)]
dout[0] = [url]
to_download = []
for i in range(1,max_depth+1,1):
   for link in dout[i-1]:
      d = check_html(link)
      if d[0] == False:
         to_download.append(link)###Append to the list of downloads
      else:
         for j in range(len(d[1])):
            d[1][j]=link+d[1][j]
            dout[i] += d[1]###Add all the subdirectories to check in next depth level

####Now we have a list of links to download         
for link in to_download:
    download_file(link)


