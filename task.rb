require 'watir'
require 'selenium-webdriver'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'byebug'

class Account
attr_accessor :name_account, :currency_account, :balance_account
attr_accessor :nature_account, :transactions_account, :numberOfTr

  def set_all_UserInfo
    #Enter
    brow = Watir::Browser.new :firefox
	  brow.goto 'https://demo.bendigobank.com.au/banking/sign_in'
	  (brow.button value: 'personal').click
    doc = Nokogiri::HTML(brow.html)

	# parse data
	  @name_account = doc.css('h6.grouped-list__group__heading').first.text
	  @currency_account = doc.css("span[data-semantic = 'header-available-balance-amount']").text[0]
	  @balance_account = doc.css("span[data-semantic = 'header-available-balance-amount']").text[1..-1]
	  @nature_account =  doc.css("h2._3r-FF99lrp").text
	#this bank loads old transactions only when you scrolling, so..we need to get some sleep
    brow.execute_script("window.scrollBy(0,4500)")
    sleep 5
    brow.execute_script("window.scrollBy(0,4500)")
    sleep 5
    brow.execute_script("window.scrollBy(0,4500)")
    sleep 5
    brow.execute_script("window.scrollBy(0,4500)")
    sleep 5
	  @transactions_ol =  brow.ol(class: ["grouped-list", "grouped-list--compact", "grouped-list--indent"])
	  @transactions_account = []

  system("cls")
#get sighs with nokogiri

iter = 0
arrayOfSigns=[]
list_trans = brow.ol(class: ["grouped-list", "grouped-list--compact", "grouped-list--indent"])
doc = Nokogiri::HTML(list_trans.html)

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
        @transactions_account.push(li.text.slice(0..(li.text.index("Balance after transaction") - 1)))
        #add a sign
        @transactions_account[iter - 1].to_s.insert((@transactions_account[iter - 1][0..-2].rindex("\n")) + 1,arrayOfSigns[iter - 1].to_s)
    else
       # goes through all transaction with the same date
      dataofTr = li.text.split("\n").first # the date
      @transactions_account.push(@transactionsOfCurData.slice(0..(@transactionsOfCurData.index("Balance after transaction") - 1)))
      iter += 1
      @transactionsOfCurData.slice!(0..(@transactionsOfCurData.index("Balance after transaction") + 26))
      @transactionsOfCurData.slice!(0..(@transactionsOfCurData.index("\n")))
       # add a sign
      @transactions_account[iter - 1].to_s.insert((@transactions_account[iter - 1][0..-2].rindex("\n"))+1,arrayOfSigns[iter - 1].to_s)
    end
  end
end
end

	def get_all_UserInfo
	  system('cls')
	  json_out = {"name" => @name_account,"currency" => @currency_account,"balance" => @balance_account,"nature" => @nature_account,"transactions" => @transactions_account }
    puts JSON.pretty_generate(json_out)
 	end

end

class Transactions
attr_accessor :data, :description, :amount, :currency, :account_name

  def set_allDataTr(transaction_user, account)
    @transaction = transaction_user.clone
    @data = @transaction.slice!(0..@transaction.index("\n")).chop
    @transaction.to_s.chop!
    @currency = @transaction.slice!((@transaction.rindex("\n") + 2)..(@transaction.rindex("\n") + 2))
    @amount = @transaction.slice!(@transaction.rindex("\n") + 1..-1)
    @account_name = account.name_account
    @description = @transaction
    @account_currancy = account.currency_account
    @account_balance = account.balance_account
    @account_nature = account.nature_account
  end

  def trans_output_json
   json_out = {"date" => @data,"description" => @description,"amount" => @amount,"currency" => @currency,"account_name" => @account_name}
   # return ("{ 'transaction':[  { #{json_out.to_json}")
   return JSON.pretty_generate(json_out)
  end
#"transactions" => trans_output_json
  def general_output
    trans = {"date" => @data,"description" => @description,"amount" => @amount,"currency" => @currency,"account_name" => @account_name}
    json_out = {"name" => @account_name,"currency" => @account_currancy,"balance" => @account_balance,"nature" => @account_nature,"transactions" => trans}
    puts ("{ \n'accounts':[")
    puts JSON.pretty_generate(json_out)
    puts "}\n]\n}"
  end
end


# Uncomment all following cod to test classes without test_spec.rb

# #testing Account class
# account_user = Account.new
# trans_user = Transactions.new
# general_trans_user = Transactions.new
#
# account_user.set_all_UserInfo
# account_user.get_all_UserInfo
# numberOfTransactions = account_user.numberOfTr - 1
#
# #testing Transactions & Account class with complete output
#
# puts " Press 1 to check general output, press 2 to check local transactions output, press 3 to exit "
# answer = gets.chomp
# loop do
# if answer == "1"
#   for j in 0..numberOfTransactions
#     trans_user.set_allDataTr(account_user.transactions_account[j],account_user)
#     trans_user.general_output
#   end
#   puts " Press 1 to check general output, press 2 to check local transactions output, press 3 to exit "
#   answer = gets.chomp
#
# elsif answer == "2"
#   for i in 0..numberOfTransactions
#   general_trans_user.set_allDataTr(account_user.transactions_account[i],account_user)
#   puts general_trans_user.trans_output_json
#   end
#   puts " Press 1 to check general output, press 2 to check local transactions output, press 3 to exit "
#   answer = gets.chomp
#
# elsif answer == "3"
#   break
# else
#   puts " Just 1 or 2"
#   answer = gets.chomp
# end
# end
