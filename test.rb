require 'watir'
require 'selenium-webdriver'
require 'nokogiri'
require 'open-uri'
require 'restclient'
require 'byebug'
b = Watir::Browser.new :firefox
b.goto 'https://demo.bendigobank.com.au/banking/sign_in'

#Входим
(b.button value: 'personal').click


#doc = Nokogiri::HTML(b.html)

#b.execute_script("window.scrollBy(0,4500)")
sleep 5
b.execute_script("window.scrollBy(0,4500)")

sleep 5
b.execute_script("window.scrollBy(0,4500)")

sleep 5
b.execute_script("window.scrollBy(0,4500)")

sleep 5

# puts doc.css('h6.grouped-list__group__heading').first.text

# puts doc.css("span[data-semantic = 'header-available-balance-amount']").text[1..-1]
# puts doc.at('h6.grouped-list__group__heading')
system('cls')


arra=[]
x = b.ol(class: 'grouped-list grouped-list--compact grouped-list--indent')
doc = Nokogiri::HTML(x.html)
# puts doc.css('path')[0]['d']
for i in 0..(doc.css('path').size)-1
# puts doc.css('path')[i]['d']
if doc.css('path')[i]['d'][0..2] == "M5 "
  arra.push("+")
end
if doc.css('path')[i]['d'][0..2] == "M2 "
  arra.push("-")
end
#(byebug) puts (doc.css('path')[2]['d'][0..1]) =="M7"
end
byebug
puts "se"
