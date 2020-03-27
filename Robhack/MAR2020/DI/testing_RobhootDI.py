import RobhootDIpy as rh

# URLs to automatically extract data from

urls = ['https://population.un.org/wpp/Download/Standard/Population/', #worldpop, pragmatic
        'https://www.worldpop.org/sdi/advancedapi',#worldpop
        'https://gadm.org/download_world.html',#boundaries
        'http://www.migrationpolicycentre.eu/globalmobilities/dataset/',#transnational mobility
        'https://www.gisaid.org/epiflu-applications/next-hcov-19-app/',
        'https://covid2019-api.herokuapp.com/v2/current',
        'https://envidatrepo.wsl.ch/uploads/chelsa/',
        'https://millionneighborhoods.org/#2.45/25.19/23.79',
        'https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-density-rev11'
       ]
# Extracting the data
for url in urls:
    rh.extract.download_file(url)
