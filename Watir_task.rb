require 'watir'
require 'selenium-webdriver'
require 'json'

class Account
  def get_name_account
    puts "#{@name_account}"
  end

  def name_account
    @name_account = b.div(class: '_23LTBXgogQ').child.child.child.text
  end

  def get_currency
    puts "#{@currency}"
  end

  def currency
    @currency = b.div(class: '_3r9Q7pu08-').child.text[0]
  end

  def get_balance
    puts "#{@balance}"
  end

  def balance
    @balance = b.div(class: '_3r9Q7pu08-').child.text.slice(1..-1)
  end

  def get_nature
    puts "#{@nature}"
  end

  def nature
    @nature = b.h2(class: '_3r-FF99lrp').text
  end

  def get_transactions
    @transactions
  end

		#this bank loads old transactions only when you scrolling, so..we need to get some sleep
  def transactions
    sleep 5
    b.execute_script("window.scrollBy(0,4500)")
	sleep 3
	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	b.execute_script("window.scrollBy(0,4500)")

	#now we can write all transaction( at least 5 times enough to get 2-3 mounts)
	@transactions_ol =  b.ol(class: 'grouped-list grouped-list--compact grouped-list--indent')
	@transactions = ''

	@transactions_ol.each do |li|
 	@transactions += li.text
 		end
	end


  #all methods in one method
  def set_all_UserInfo
    b = Watir::Browser.new :firefox
	b.goto 'https://demo.bendigobank.com.au/banking/sign_in'

	#Входим
	(b.button value: 'personal').click
	# Копируем данные
	@name_account = name_account = b.div(class:'_23LTBXgogQ').child.child.child.text
	@currency = b.div(class: '_3r9Q7pu08-').child.text[0]
	@balance = b.div(class: '_3r9Q7pu08-').child.text.slice(1..-1)
	@nature = b.h2(class: '_3r-FF99lrp').text
	# #this bank loads old transactions only when you scrolling, so..we need to get some sleep

	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	b.execute_script("window.scrollBy(0,4500)")
	sleep 5
	@transactions_ol =  b.ol(class: 'grouped-list grouped-list--compact grouped-list--indent')
	@transactions = []

	@transactions_ol.each do |li|
 	@transactions.push("#{li.text}")

 		end



	end


	def get_all_UserInfo

	  system('cls') #it's a compromies. I will solve the problem with two warnings and this 'system-cls' code will be useless
	  json_out = { "name" => @name_account,"currency" => @currency,"balance" => @balance,"nature" => @nature,"transactions" => @transactions }

	  puts ("{ \n'accounts':[")

	  puts json_out.to_json

	  puts "}\n]\n}"

 	end



end



test_obj = Account.new
  test_obj.set_all_UserInfo
  test_obj.get_all_UserInfo

  puts "Output of transactions looks like a mess , but it's real and almost normal 'transactions' "
  puts "It's ↓ just a double output of transactions, but in normal style (because i'm still struggling to do a good output that don't ignor '/n' "
  puts test_obj.get_transactions
