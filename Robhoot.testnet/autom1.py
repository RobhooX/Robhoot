import datetime as dt
#import matplotlib.pyplot as plt
#from matplotlib import style
import pandas as pd
import pandas_datareader.data as web

import requests # telegram url


#style.use('ggplot')

#stock in portfolio
stock=['AAPL','DAI.DE','GOOGL','TSLA','AMZN','EA','VOLV-A.ST','GAMR','BTC-USD','ETH-USD']
amount =[27,110,12,35,10,72,90,175,0.2,2]
initial=[172.43,72.5,1095.5,335.49,1448.69,126.02,155.1,49.69,11148.6,1126.22]

start = dt.datetime(2019, 12, 31)
end = dt.datetime.now()


for i in range(len(stock)):
    df = web.DataReader(stock[i], 'yahoo', start, end)
    #df = web.DataReader("DAI.DE", 'yahoo', start, end)
    df.reset_index(inplace=True)
    df.set_index("Date", inplace=True)
    #df = df.drop("Symbol", axis=1)

print(df.head())


url = "https://api.telegram.org/bot1047051671:AAH6ZsMKmTJ1680JQTqwpivxBrruSy9Y1XU/getUpdates" 

def send_mess(df): 
    params = {'chat_id':-319178712, 'text': df} 
    response = requests.post(url + 'sendMessage',data=params) 

    return response
    
#send_mess(result_you_want_to_send)
send_mess(response)










                                                                                                                                                                                                                                                                                                               
