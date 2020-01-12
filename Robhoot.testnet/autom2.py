
import telegram

#token that can be generated talking with @BotFather on telegram

my_token ='1047051671:AAH6ZsMKmTJ1680JQTqwpivxBrruSy9Y1XU'

def send(msg, chat_id, token=my_token):
	#Send a mensage to a telegram user specified on chatId
	#chat_id must be a number!
    bot= telegram.Bot(token)
    bot.sendMessage(chat_id='-279263276',msg='text')
 
 
 