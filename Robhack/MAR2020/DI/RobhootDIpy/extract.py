import os
import requests
from mimetypes import guess_extension
from bs4 import BeautifulSoup,SoupStrainer

def download_file(url,path = './data/raw_data'):
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
        if ext in ['.html', '.htm']:
            print('This resource is an html site and I will not download it by now')
            return status
            # get links as urls2, but only until certain depth/number of calls (be careful not to make infinite loop)
            #for urls in urls2:
                #download_file(url)
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
    ####Problems with files in format '.7z' and '.lnk', cannot guess_extension
    # if url[-3:]=='.7z':
    #     return([False,[]])
    # elif url[-4:]=='.lnk':
    #     return([False,[]])
    # else:
    ext = guess_extension(sread.headers['content-type'].partition(';')[0].strip())
    if ext not in ['.html', '.htm']:
        return([False,[]])
    else:
        return([True,getlinks(sread)])



# THIS IS SPECIFIC FOR THE ENVIRONMENTAL DATA BUT SOME FUNCTIONALITY MIGHT BE REUSABLE

#url='https://envidatrepo.wsl.ch/uploads/chelsa/'
#max_depth =5  ###Maximum depth we will look from the parent directory
#dout = [[] for i in range(max_depth+1)]
#dout[0] = [url]
#to_download = []
#problems=['/uploads/','?C=N;O=D','?C=N;O=D','?C=M;O=A','?C=D;O=A','?C=S;O=A']
#for i in range(1,max_depth+1,1):
#     for link in dout[i-1]:
# #        print(link)
#         d = check_html(link)
#         if d[0] == False:
#             to_download.append(link)###Append to the list of downloads
#         else:
#             l0=link.replace('https://envidatrepo.wsl.ch','')
#             for elem in d[1]:
#                 if elem in l0:#Avoid moving to previous depths
#                     d[1].remove(elem)
#             for elem in problems:#Avoid strange links
#                 if elem in d[1]:
#                     d[1].remove(elem)
#             for j in range(len(d[1])):
#                 d[1][j]=link+d[1][j]
#             dout[i] += d[1]###Add all the subdirectories to check in next depth level
####Now we have a list of links to download
# for link in to_download:
#     download_file(link)
