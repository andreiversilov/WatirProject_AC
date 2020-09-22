require 'watir'
require 'selenium-webdriver'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'byebug'
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
    doc = Nokogiri::HTML(b.html)

	# parse data
	@name_account = doc.css('h6.grouped-list__group__heading').first.text
	@currency = doc.css("span[data-semantic = 'header-available-balance-amount']").text[0]
	@balance = doc.css("span[data-semantic = 'header-available-balance-amount']").text[1..-1]
	@nature =  doc.css("h2._3r-FF99lrp").text
	#this bank loads old transactions only when you scrolling, so..we need to get some sleep

  sleep 5
  b.execute_script("window.scrollBy(0,4500)")
  sleep 5
  b.execute_script("window.scrollBy(0,4500)")
  sleep 5
  b.execute_script("window.scrollBy(0,4500)")

  sleep 5
	@transactions_ol =  b.ol(class: ["grouped-list", "grouped-list--compact", "grouped-list--indent"])
	@transactions = []

  system("cls")
#get sighs with nokogiri

iter = 0

arrayOfSigns=[]
x = b.ol(class: ["grouped-list", "grouped-list--compact", "grouped-list--indent"])
doc = Nokogiri::HTML(x.html)

for i in 0..(doc.css('path').size)-1
  if doc.css('path')[i]['d'][0..2] == "M5 "
    arrayOfSigns.push("+")
  end
  if doc.css('path')[i]['d'][0..2] == "M2 "
    arrayOfSigns.push("-")
end
end

@numberOfTr = arrayOfSigns.size
@transactions_ol.drop(1).each_with_index do |li,i|
@transactionsOfCurData = li.text
  for j in 1..(li.text.scan("Balance after transaction").size)
    if li.text.split("\n").first != @transactionsOfCurData.split("\n").first
      @transactionsOfCurData.insert(0,li.text.split("\n").first + "\n")
    end
    if (li.text.scan("Balance after transaction").size==1)
        iter += 1
        @transactions.push( li.text.slice(0..(li.text.index("Balance after transaction")-1))  )
        #add a sign
        @transactions[iter-1].to_s.insert((@transactions[iter-1][0..-2].rindex("\n"))+1,arrayOfSigns[iter-1].to_s)
    else
       # goes through all transaction with the same date
      dataofTr = li.text.split("\n").first # the date
      @transactions.push(@transactionsOfCurData.slice(0..(@transactionsOfCurData.index("Balance after transaction")-1)) )
      iter += 1
      @transactionsOfCurData.slice!(0..(@transactionsOfCurData.index("Balance after transaction") + 26 ))
      @transactionsOfCurData.slice!(0..(@transactionsOfCurData.index("\n")))
       # add a sign
      @transactions[iter-1].to_s.insert((@transactions[iter-1][0..-2].rindex("\n"))+1,arrayOfSigns[iter-1].to_s)
    end
  end
end

end

	def get_all_UserInfo
	  system('cls')
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

  def set_allDataTr(transaction, account)
  @data = transaction.slice!(0..transaction.index("\n"))
  transaction.chop!
  @currency = transaction.slice!((transaction.rindex("\n")+2)..(transaction.rindex("\n")+2))
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

#testing Account class
account_user = Account.new
account_user.set_all_UserInfo
account_user.get_all_UserInfo

#testing Transactions & Account class with complete output
trans_user= Transactions.new
for i in 0..account_user.numberOfTr-1
trans_user.set_allDataTr(account_user.transactions[i],account_user)
trans_user.general_output
end
