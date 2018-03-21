ENV["SSL_CERT_FILE"] = "C:/Ruby23-x64/cacert.pem"
require 'telegram/bot'
require 'screencap'
require 'phantomjs'
Phantomjs.path
token = '257957425:AAF66kHImNt3gB_s9aCVuyBqzj8smYrsp5Y'
Telegram::Bot::Client.run(token) do |bot|
  puts 'Bot was started.'
  bot.listen do |message|
    if message.text == 'старт'
      bot.api.sendMessage(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}")
	elsif message.text == 'найди'
	  bot.api.sendMessage(chat_id: message.chat.id, text: "Что?")
	  bot.listen do |message|
	    text = message.text.downcase
		break
	  end
	  f = Screencap::Fetcher.new('https://ru.wikipedia.org/wiki/#{text}')
      screenshot = f.fetch
	  bot.api.sendMessage(chat_id: message.chat.id, text: "Нашёл.")
	  bot.api.send_photo(chat_id: message.chat.id, photo: screenshot)
    end
  end
end