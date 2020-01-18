# pip install datareader
import pandas as pd
pd.core.common.is_list_like = pd.api.types.is_list_like
import pandas_datareader as web
import matplotlib.pyplot as plt
import numpy as np

from datetime import datetime, timedelta

#stock of interest
stock=['MSFT','SAP','V','JPM']

# period of analysis
end = datetime.now()
start = end - timedelta(days=500)

for i in range(len(stock)):
    f = web.DataReader(stock[i], 'morningstar', start, end)

    # nice looking timeseries (DataFrame to panda Series)
    f = f.reset_index()
    f = pd.Series(f.Close.values,f.Date)

    #print "Start: Year, Month, Day, Time"
    print("Start: Year, Month, Day, Time")
    #print str(start)
    f.plot(label=stock[i]);
    plt.legend()
    plt.ylabel('price in [USD]')

plt.show();
