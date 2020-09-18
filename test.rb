require 'watir'
require 'selenium-webdriver'
require 'json'

b = Watir::Browser.new :firefox
b.goto 'https://demo.bendigobank.com.au/banking/sign_in'
	(b.button value: 'personal').click


transactions_ol =  b.ol(class: 'grouped-list grouped-list--compact grouped-list--indent')
puts b.ol(class: 'grouped-list grouped-list--compact grouped-list--indent').child.child.child.child.child.child.child.child.style()
