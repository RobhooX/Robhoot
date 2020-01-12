import requests 


def telegram_bot_sendtext(bot_message): 

    bot_token = '1047051671:AAH6ZsMKmTJ1680JQTqwpivxBrruSy9Y1XU' 
    bot_chatID = '-279263276'
    send_text = 'https://api.telegram.org/bot' 1047051671:AAH6ZsMKmTJ1680JQTqwpivxBrruSy9Y1XU '/sendMessage?chat_id=' 279263276 '&parse_mode=Markdown&text=' + bot_message 
    
    #send_text = 'https://api.telegram.org/bot' + bot_token + '/sendMessage?chat_id=' + bot_chatID + '&parse_mode=Markdown&text=' + bot_message

    
    response = requests.get(send_text) 
    return response.json() 
    
test = telegram_bot_sendtext("Testing Telegram bot") print(test)
