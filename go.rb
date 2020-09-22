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

  def numberOfTr
    @numberOfTr
  end

  def set_all_UserInfo
    #Enter
    b = Watir::Browser.new :firefox
	  b.goto 'https://demo.bendigobank.com.au/banking/sign_in'
	 (b.button value: 'personal').click

	# parse data
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
  #b.ol include all transactions
	@transactions_ol = b.ol(class: ["grouped-list", "grouped-list--compact", "grouped-list--indent"])
	@transactions = []
  dataOfTr = ""
  @numberOfTr = 0
	@transactions_ol.drop(1).each_with_index do |li,i|

    @transactionsOfCurData = li.text
    @numberOfTr += li.text.scan("Balance after transaction").size

    for j in 1..(li.text.scan("Balance after transaction").size)
      if li.text.split("\n").first != @transactionsOfCurData.split("\n").first
        @transactionsOfCurData.insert(0,li.text.split("\n").first + "\n")
      end
      if (li.text.scan("Balance after transaction").size==1)

        @transactions.push( li.text.slice(0..(li.text.index("Balance after transaction")-1))  )

      else
# if we have a lot of transactions in a date
      dataofTr = li.text.split("\n").first # the date
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

  def set_allDataTr(transaction,account)

  @data = transaction.slice!(0..transaction.index("\n"))
  transaction.chop!
  @currency = transaction.slice!((transaction.rindex("\n")+1)..(transaction.rindex("\n")+1))
  @amount =transaction.slice!(transaction.rindex("\n")..-1)
  @account_name = account.name_account
  @description = transaction

  @account_currancy = account.currency
  @account_balance = account.balance
  @account_nature = account.nature

end

  def output_json
    json_out = {"date" => @data,"description" => @description,"amount" => @amount,"currency" => @currency,"account_name" => @account_name}
    ("{ 'transaction':[  { #{json_out.to_json}")
  end

  def general_output
    json_out = {"name" => @account_name,"currency" => @account_currancy,"balance" => @account_balance,"nature" => @account_nature,"transactions" => output_json}
    puts ("{ \n'accounts':[")
    puts json_out.to_json
    puts "}\n]\n}"
  end
end

#test
account_user = Account.new
account_user.set_all_UserInfo
puts account_user.get_all_UserInfo

trans_user= Transactions.new
for i in 0..account_user.numberOfTr-1
trans_user.set_allDataTr(account_user.transactions[i], account_user)
trans_user.general_output
end
