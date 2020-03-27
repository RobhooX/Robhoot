import RobhootDIpy.discover as discover
import RobhootDIpy.extract as extract
import RobhootDIpy.transform as transform
import RobhootDIpy.load as load
import pandas as pd
import sys
import numpy as np
# URLs to automatically extract data from

resources = ['https://worldpopulationreview.com/countries/country-codes/', #country iso codes, taken manually
             'https://population.un.org/wpp/Download/Standard/Population/', #world populations, parent
             'https://ec.europa.eu/knowledge4policy/node/35849_es' #transnational mobility, taken manually
             'https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/EXCEL_FILES/1_Population/WPP2019_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES.xlsx', #world populations
             'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv', #epidemic data confirmed cases
             'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv', #epidemic data deaths cases
             'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv' #epidemic data recovered cases (will disappear)
            ]

for url in resources:
    extract.download_file(url)


    
# # Data for RobSIR 1.0
#
# ## CAUTION: WE NEED TO IMPLEMENT THE FOLLOWING CELLS THAT READ DATA AND PUT IT IN THE FORMAT FOR ROBSIR WITH [PANDAS](https://pandas.pydata.org/) TO BE MORE EFFICIENT

# ### Country ISO codes
#
# I will do everything with the codes that describe the country with three letters (Alpha-3 codes).
#
# Source: [World population review](https://worldpopulationreview.com/countries/country-codes/) They say that the codes come from the [International Organization for Standardization](https://www.iso.org/iso-3166-country-codes.html) but this organization charges for a csv of their codes.


dfISO = pd.read_csv('./data/country_ISO_codes.csv')
# print(dfISO.head())

# country_code ={}
# for line in fin:
#     line = line.split(',')
#     if line[0].split('"')[1] != 'name':
#         country_number = int(line[3].split('"')[1])
#         ccode = line[2].split('"')[1]
#         country_code[country_number] = ccode


# ### Population estimates
#
# Source: [UN World Population Prospects 2019](https://population.un.org/wpp/Download/Standard/Population/). I did already choose the columns and rows that I wanted, but, again, this should be done via [pandas](https://pandas.pydata.org/).

dfpop = pd.read_excel('./data/population_un_org_wpp_Download_Files_1_Indicators%20(Standard)_EXCEL_FILES_1_Population_WPP2019_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES_xlsx.xlsx',sheet_name='ESTIMATES',skiprows=16,usecols=["Region, subregion, country or area *",'Country code','2020'])
#dfpop = dfpop[["Region, subregion, country or area *",'Country code','2020']].copy()
samp = list(dfpop['2020'])
samp = list(map(lambda x:x*1000,samp))
dfpop['2020'] = samp
codes = list(dfpop['Country code'])
codes3 = [None for i in range(len(codes))]
for index,row in dfISO.iterrows():
    c1 = row['cca3']
    c2 = row['ccn3']
    k  = codes.index(c2)
    if k != False:
        codes3[k] = c1
dfpop['Codes3'] = codes3
# print(dfpop.head(50))


#fin = open('./data/population_estimates_UN_2020.csv')
# pop = {}
# for line in fin:
#     line = line.split(',')
#     if line[0] != '"Region':
#         if len(line) < 5:
#             country_number = int(line[1])
#             if country_number in country_code.keys():
#                 aux = line[2].split('"')
#                 if len(aux) == 1:
#                     cpop = int(aux[0])*1000
#                 else:
#                     cpop = int(aux[1])*1000
#                 if len(line) == 4:
#                     aux = line[3].split('"')[0]
#                     temp = '{:<03}'
#                     res = temp.format(aux)
#                     cpop += int(res            )
#                 pop[country_code[country_number]] = cpop

# ### Mobility network
#
# Source: [European comission Global Transnational Mobility Dataset](https://ec.europa.eu/knowledge4policy/node/35849_es). It has mobility between countries (directed) in number of trips for a year between 2011 and 2016. Just keeping the 2016 one. It is not completely symmetric, so we can think if we want to symmetrize it. Here I am storing it as a networkx directed graph. For storing I would use an edgelist although robsir is expecting a square matrix.

dftrips = pd.read_csv("./data/KCMD_DDH_data_KCMD-EUI GMP_ Estimated trips.csv")
dftrips2 = dftrips[dftrips['time']==2016][dftrips['value']!=0]
# print(dftrips2.head(20),len(dftrips)/6,len(dftrips2))
names = list(np.unique(list(np.unique(dftrips2['reporting country']))+list(np.unique(dftrips2['secondary country']))))
N = len(names)
matr = []
for name in names:
    vec=[0 for i in range(N)]
    samp=dftrips2[dftrips2['reporting country']==name]
    targets=list(samp['secondary country'])
    weights=list(samp['value'])
    for j in range(len(targets)):
        name2=targets[j]
        k=names.index(name2)
        vec[k]=weights[j]
    matr.append(vec)

#print(matr[0], len(matr), len(matr[0]))
# names2=['Source']+names
# dfmob=pd.DataFrame(columns=names2)
# for i in range(len())
# for name,vec in zip(names,matr):
#     dfmob=dfmob.append(pd.DataFrame([name]+vec, columns = names2))
# dfmob=dfmob.set_index('Source')
# print(dfmob.head(2))

sys.exit()

# import networkx as nx
# g = nx.DiGraph()
# fin = open('./data/')
# for line in fin:
#     line = line.split(',')
#     if line[0] != 'reporting country':
#         fr = line[0]
#         to = line[1]
#         year = int(line[2])
#         if year == 2016:
#             if fr in pop.keys() and to in pop.keys():
#                 flux = int(line[3])
#                 g.add_edge(fr, to, weight = flux)


# ### Epidemic data
#
# The epidemic data is taken from the [Johns Hopkins CSSE repository](https://github.com/CSSEGISandData/COVID-19). Three tables for [confirmed](https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv), [deaths](https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv) and [recovered](https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv). Recovered will disappear from this dataset.
#
# Alternative source which seems to have alreade the county data for the USA is [coronascraper](https://coronadatascraper.com/#home).


import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import datetime

fin = open('./data/time_series_covid19_confirmed_global.csv')
confirmed_ts = {}
for line in fin:
    line = line.split(',')
    if line[0] == 'Province/State':
        totlen = len(line)
        t = [line[i].rstrip('\n') for i in range(4,len(line))]
    else:
        if len(line) == totlen:
            if line[1] not in confirmed_ts.keys():
                confirmed_ts[line[1]] = np.array([int(line[i]) for i in range(4,len(line))])
            else:
                confirmed_ts[line[1]] += np.array([int(line[i]) for i in range(4,len(line))])
        else:
            country = line[1]+','+line[2]
            if line[1] not in confirmed_ts.keys():
                confirmed_ts[line[1]] = np.array([int(line[i]) for i in range(5,len(line))])
            else:
                confirmed_ts[line[1]] += np.array([int(line[i]) for i in range(5,len(line))])

for country in confirmed_ts.keys():
    plt.yscale('log')
    plt.plot(t, confirmed_ts[country])


# In[59]:


fin = open('./data/time_series_covid19_deaths_global.csv')
deaths_ts = {}
for line in fin:
    line = line.split(',')
    if line[0] == 'Province/State':
        totlen = len(line)
        t = [line[i].rstrip('\n') for i in range(4,len(line))]
    else:
        if len(line) == totlen:
            if line[1] not in deaths_ts.keys():
                deaths_ts[line[1]] = np.array([int(line[i]) for i in range(4,len(line))])
            else:
                deaths_ts[line[1]] += np.array([int(line[i]) for i in range(4,len(line))])
        else:
            country = line[1]+','+line[2]
            if line[1] not in deaths_ts.keys():
                deaths_ts[line[1]] = np.array([int(line[i]) for i in range(5,len(line))])
            else:
                deaths_ts[line[1]] += np.array([int(line[i]) for i in range(5,len(line))])

for country in deaths_ts.keys():
    plt.yscale('log')
    plt.plot(t, deaths_ts[country])


# In[62]:


fin = open('./data/time_series_covid19_recovered_global.csv')
recovered_ts = {}
for line in fin:
    line = line.split(',')
    if line[0] == '\ufeffProvince/State':
        #print(line)
        totlen = len(line)
        t = [line[i].rstrip('\n') for i in range(4,len(line))]
    else:
        if len(line) == totlen:
            if line[1] not in recovered_ts.keys():
                recovered_ts[line[1]] = np.array([int(line[i]) for i in range(4,len(line))])
            else:
                recovered_ts[line[1]] += np.array([int(line[i]) for i in range(4,len(line))])
        else:
            country = line[1]+','+line[2]
            if line[1] not in recovered_ts.keys():
                #print(line)
                recovered_ts[line[1]] = np.array([int(line[i]) for i in range(5,len(line))])
            else:
                recovered_ts[line[1]] += np.array([int(line[i]) for i in range(5,len(line))])

for country in recovered_ts.keys():
    plt.yscale('log')
    plt.plot(t, recovered_ts[country])


# In[ ]:
