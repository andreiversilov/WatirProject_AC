# frozen_string_literal: true

class Transactions
  attr_accessor :date, :description, :amount, :currency, :user_name, :count

  def initialize(account)
    mounts = { 'January' => '01', 'February' => '02', 'March' => '03', 'April' => '04', 'May' => '05',
               'June' => '06', 'July' => '07', 'August' => '08', 'September' => '09', 'October' => '10',
               'November' => '11', 'December' => '12' }

    @date = []
    @currency = []
    @amount = []
    @description = []
    @count = 0
    account.transactions_account.each do |transaction_user|
      @count += 1
      transaction = transaction_user.to_s.dup

      raw_data = transaction.slice!(0..transaction.to_s.index("\n")).chop
      year = raw_data.to_s.slice!(-5..-1).strip
      number = raw_data.to_s.slice!(-3..-2).strip
      number.insert(0, '0') if number.size == 1
      mon = raw_data.chop!.strip
      data_json = "#{year}-#{mounts[mon]}-#{number}"
      @date.push(data_json)

      transaction.to_s.chop!
      @amount.push(transaction.slice!((transaction.rindex("\n").to_i + 1)..-1).tr(',', '').to_f)

      @description.push(transaction.chomp)
    end
    @currancy = account.currency_account
    @user_name = account.user_name
    @account_currancy = account.currency_account
    @account_balance = account.balance_account
    @type_account = account.type_account
  end

  def trans_output_json
    all_transaction = []
    (0..@count - 1).each do |i|
      trans = { "date" => @date[i], "description" => @description[i], "amount" => @amount[i], 'currency' => @currancy, "account_name" => @type_account }
      all_transaction.push(trans)
    end
    all_transaction
  end

  def general_output
      File.open('temp.json', 'w') do |file|
        file.puts ""
      end
    (0..@count - 1).each do |i|
      trans = { 'date' => @date[i], 'description' => @description[i], 'amount' => @amount[i], 'currency' => @currancy, "account_name" => @type_account }
      json_out = { 'account' => ['name' => @user_name, 'currency' => @account_currancy, 'balance' => @account_balance, 'nature' => @type_account, 'transactions' => [trans]] }

      File.open('temp.json', 'a') do |file|
        file.puts JSON.pretty_generate(json_out)
      end
    end
  end
end
