import RobhootDIpy.discover as discover
import RobhootDIpy.extract as extract
import RobhootDIpy.transform as transform
import RobhootDIpy.load as load
import pandas as pd
import sys
import numpy as np
import os

# DATA DOWNLOAD

path_raw_data = './data/raw_data/'
if not os.path.exists(path_raw_data):
    os.makedirs(path_raw_data)

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

# DATA TRANSFORMATION AND STORAGE

path_transformed_data = './data/transformed_data/'
if not os.path.exists(path_transformed_data):
    os.makedirs(path_transformed_data)
    
# # Data for RobSIR 1.0
#
# ### Country ISO codes
#
# Source: [World population review](https://worldpopulationreview.com/countries/country-codes/) They say that the codes come from the [International Organization for Standardization](https://www.iso.org/iso-3166-country-codes.html) but this organization charges for a csv of their codes.


dfISO = pd.read_csv(path_raw_data+'country_ISO_codes.csv')

# ### Population estimates
#
# Source: [UN World Population Prospects 2019](https://population.un.org/wpp/Download/Standard/Population/). I did already choose the columns and rows that I wanted, but, again, this should be done via [pandas](https://pandas.pydata.org/).

dfpop = pd.read_excel(path_raw_data+'population_un_org_wpp_Download_Files_1_Indicators%20(Standard)_EXCEL_FILES_1_Population_WPP2019_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES_xlsx.xlsx',sheet_name='ESTIMATES',skiprows=16,usecols=["Region, subregion, country or area *",'Country code','2020'])
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



# ### Mobility network
#
# Source: [European comission Global Transnational Mobility Dataset](https://ec.europa.eu/knowledge4policy/node/35849_es). It has mobility between countries (directed) in number of trips for a year between 2011 and 2016. Just keeping the 2016 one. It is not completely symmetric, so we can think if we want to symmetrize it. Here I am storing it as a networkx directed graph. For storing I would use an edgelist although robsir is expecting a square matrix.

dftrips = pd.read_csv(path_raw_data+"KCMD_DDH_data_KCMD-EUI GMP_ Estimated trips.csv")
dftrips2 = dftrips[dftrips['time']==2016][dftrips['value']!=0]
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
    
dfmob = pd.DataFrame(columns=names,index=names)

for i in range(len(names)):
    index = names[i]
    dfmob.loc[index]=matr[i]
#### KEEP ONLY POPULATION IN COUNTRIES WITH MOBILITY
dfpop = dfpop[dfpop['Codes3'].notnull()]

#### EXPORT TO CSV

dfISO.to_csv(path_transformed_data+'countrycodes.csv',index=False)
dfpop[['Codes3','2020']].to_csv(path_transformed_data+'population.csv',index=False)
dfmob.to_csv(path_transformed_data+'mobility.csv')

# ### Epidemic data
#
# The epidemic data is taken from the [Johns Hopkins CSSE repository](https://github.com/CSSEGISandData/COVID-19). Three tables for [confirmed](https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv), [deaths](https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv) and [recovered](https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv). Recovered will disappear from this dataset.
#
# Alternative source which seems to have alreade the county data for the USA is [coronascraper](https://coronadatascraper.com/#home).

# load epidemilological data, change name of country to code of three letters and aggregate the provinces in a country

# COUNTRIES NOT RECOGNISED:


# Cabo Verde
# Congo (Brazzaville)
# Congo (Kinshasa)
# Cote d'Ivoire
# Czechia
# Diamond Princess
# Eswatini
# Holy See
# Korea, South
# Kosovo
# North Macedonia
# Taiwan*
# US
# West Bank and Gaza

def give_country_code_aggregate(fname, fout = False, path_raw = './data/raw_data/', path_trans = './data/transformed_data/'):
    if not fout:
        fout = fname
    dfconf = pd.read_csv(path_raw+fname)
    cnames = list(np.unique(dfconf['Country/Region']))
    cols = list(dfconf.columns)
    to_remove = ['Province/State','Lat','Long']
    for elem in to_remove:
        cols.remove(elem)

    dfconf_agg = pd.DataFrame(columns=cols,index=names)
    dates = cols.copy()
    dates.remove('Country/Region')


    for name in cnames:
        samp = dfconf[dfconf['Country/Region'] == name]
        vec = []
        samp2 = dfISO['cca3'][dfISO['name'] == name]
        if len(samp2)>0:
            cca = list(samp2)
            vec.append(cca[0])
        else:
            print(name)
            vec.append(',')
        for date in dates:
            # print(name,samp[date])
            # sys.exit()
            n=samp[date].sum()
            vec.append(n)
        print(vec)
        dfconf_agg.loc[name]=vec
    dfconf_agg = dfconf_agg.set_index('Country/Region')
    print(dfconf_agg.head())
    print('I am going to write!')
    dfconf_agg.to_csv(path_trans+fout)
    print('Done!')
    return dfconf_agg

datafiles = ['raw_githubusercontent_com_CSSEGISandData_COVID-19_master_csse_covid_19_data_csse_covid_19_time_series_time_series_covid19_confirmed_global_csv.bat',
             'raw_githubusercontent_com_CSSEGISandData_COVID-19_master_csse_covid_19_data_csse_covid_19_time_series_time_series_covid19_deaths_global_csv.bat',
             'raw_githubusercontent_com_CSSEGISandData_COVID-19_master_csse_covid_19_data_csse_covid_19_time_series_time_series_covid19_recovered_global_csv.bat'
            ]

dataout = ['confirmed.csv','deaths.csv','recovered.csv']
for i in range(1):
    give_country_code_aggregate(datafiles[i],fout = dataout[i])
#map(give_country_code_aggregate,datafiles,dataout)
sys.exit()
#c0 = list(dfISO['name'])
#print(dfISO[dfISO['name'] == 'Namibia'])

#for name in cnames:
#    if name not in cnames:
#        print(name)
ccodes = []
for name in cnames:
    samp=dfISO[dfISO['name']==name]
        
sys.exit()

date_format = '%m/%d/%y'

# import matplotlib.pyplot as plt

# fin = open('./data/raw_data/time_series_covid19_confirmed_global_csv.bat')
# confirmed_ts = {}
# for line in fin:
#     line = line.split(',')
#     if line[0] == 'Province/State':
#         totlen = len(line)
#         t = [line[i].rstrip('\n') for i in range(4,len(line))]
#     else:
#         if len(line) == totlen:
#             if line[1] not in confirmed_ts.keys():
#                 confirmed_ts[line[1]] = np.array([int(line[i]) for i in range(4,len(line))])
#             else:
#                 confirmed_ts[line[1]] += np.array([int(line[i]) for i in range(4,len(line))])
#         else:
#             country = line[1]+','+line[2]
#             if line[1] not in confirmed_ts.keys():
#                 confirmed_ts[line[1]] = np.array([int(line[i]) for i in range(5,len(line))])
#             else:
#                 confirmed_ts[line[1]] += np.array([int(line[i]) for i in range(5,len(line))])

# for country in confirmed_ts.keys():
#     plt.yscale('log')
#     plt.plot(t, confirmed_ts[country])


# # In[59]:


# fin = open('./data/raw_data/time_series_covid19_deaths_global.csv')
# deaths_ts = {}
# for line in fin:
#     line = line.split(',')
#     if line[0] == 'Province/State':
#         totlen = len(line)
#         t = [line[i].rstrip('\n') for i in range(4,len(line))]
#     else:
#         if len(line) == totlen:
#             if line[1] not in deaths_ts.keys():
#                 deaths_ts[line[1]] = np.array([int(line[i]) for i in range(4,len(line))])
#             else:
#                 deaths_ts[line[1]] += np.array([int(line[i]) for i in range(4,len(line))])
#         else:
#             country = line[1]+','+line[2]
#             if line[1] not in deaths_ts.keys():
#                 deaths_ts[line[1]] = np.array([int(line[i]) for i in range(5,len(line))])
#             else:
#                 deaths_ts[line[1]] += np.array([int(line[i]) for i in range(5,len(line))])

# for country in deaths_ts.keys():
#     plt.yscale('log')
#     plt.plot(t, deaths_ts[country])




# fin = open('./data/raw_data/time_series_covid19_recovered_global.csv')
# recovered_ts = {}
# for line in fin:
#     line = line.split(',')
#     if line[0] == '\ufeffProvince/State':
#         #print(line)
#         totlen = len(line)
#         t = [line[i].rstrip('\n') for i in range(4,len(line))]
#     else:
#         if len(line) == totlen:
#             if line[1] not in recovered_ts.keys():
#                 recovered_ts[line[1]] = np.array([int(line[i]) for i in range(4,len(line))])
#             else:
#                 recovered_ts[line[1]] += np.array([int(line[i]) for i in range(4,len(line))])
#         else:
#             country = line[1]+','+line[2]
#             if line[1] not in recovered_ts.keys():
#                 #print(line)
#                 recovered_ts[line[1]] = np.array([int(line[i]) for i in range(5,len(line))])
#             else:
#                 recovered_ts[line[1]] += np.array([int(line[i]) for i in range(5,len(line))])

# for country in recovered_ts.keys():
#     plt.yscale('log')
#     plt.plot(t, recovered_ts[country])
