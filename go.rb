require 'watir'
require 'selenium-webdriver'
require 'json'

class Account

  def name_account
    @name_account
  end

  def currency
     @currency
  end

  def balance
    @balance
  end

  def nature
    @nature
  end

  def transactions
    @transactions

  end

 def oldversion
   @oldversion
 end

  #all methods in one method
  def set_all_UserInfo
    b = Watir::Browser.new :firefox
	b.goto 'https://demo.bendigobank.com.au/banking/sign_in'

	#Входим
	(b.button value: 'personal').click
	# Копируем данные
	@name_account = b.div(class:'_23LTBXgogQ').child.child.child.text
	@currency = b.div(class: 'css-135oqyi').child.text[0]
	@balance = b.div(class: 'css-1g6c8h1').child.text.slice(1..-1)
	@nature = b.h2(class: '_3r-FF99lrp').text
	#this bank loads old transactions only when you scrolling, so..we need to get some sleep

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
  #Delete me please

  @oldversion = []
  @transactions_ol.drop(1).each_with_index do |li,i|
     @oldversion.push(li.text)
   end

  #Delete him please
  system("cls")
  arrayOfMounts = ["JANUARY", "FEBRUARY","MARCH", "APRIL","MAY","JUNE","JULE","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"]
  dataOfTr = ""

	@transactions_ol.drop(1).each_with_index do |li,i|
    @transactionsOfCurData = li.text

    for j in 1..(li.text.scan("Balance after transaction").size)
      if li.text.split("\n").first != @transactionsOfCurData.split("\n").first
        @transactionsOfCurData.insert(0,li.text.split("\n").first + "\n")
      end
      if (li.text.scan("Balance after transaction").size==1)

        @transactions.push( li.text.slice(0..(li.text.index("Balance after transaction")-1))  )

      else
         # goes throug all transaction for one data

      dataofTr = li.text.split("\n").first # the data
      @transactions.push(@transactionsOfCurData.slice(0..(@transactionsOfCurData.index("Balance after transaction")-1)) )
      @transactionsOfCurData.slice!(0..(@transactionsOfCurData.index("Balance after transaction") + 26 ))
      @transactionsOfCurData.slice!(0..(@transactionsOfCurData.index("\n")))



    end
      end
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


class Transactions


  def data
    puts @data
  end

  def description
    puts @description
  end

  def amount
    puts @amount
  end

  def currency
    puts @currency
  end

  def account_name
    puts @account_name
  end

  def set_allDataTr(transaction,account_name)

  @data = transaction.slice!(0..transaction.index("\n"))
  transaction.chop!
  @currency = transaction.slice!((transaction.rindex("\n")+1)..(transaction.rindex("\n")+1))
  @amount =transaction.slice!(transaction.rindex("\n")..-1)
  @account_name = account_name
  @description = transaction
end

end


testobj = Account.new
testobj.set_all_UserInfo
puts testobj.oldversion
transobj = Transactions.new
transobj.set_allDataTr(testobj.transactions[0], testobj.name_account)

# puts "Here is the name "
# puts transobj.account_name
#
# puts "Here is the amount"
# puts transobj.amount
#
# puts "Here is the currency"
# puts transobj.currency
#
# puts "Here is the description"
# puts transobj.description
#
# puts "Here is the data"
# puts transobj.data
