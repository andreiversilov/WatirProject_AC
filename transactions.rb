# frozen_string_literal: true

class Transactions
  attr_accessor :date, :description, :amount, :currency, :account_name, :count

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
    @account_name = account.name_account
    @account_currancy = account.currency_account
    @account_balance = account.balance_account
    @account_nature = account.nature_account
  end

  def trans_output_json
    all_transaction = []
    (0..@count - 1).each do |i|
      trans = { 'amount' => @amount[i], 'currency' => @currancy }
      all_transaction.push(trans)
    end
    all_transaction
  end

  def general_output
    (0..@count - 1).each do |i|
      trans = { 'date' => @date[i], 'description' => @description[i], 'amount' => @amount[i], 'currency' => @currancy, 'account_name' => @account_name }
      json_out = { 'account' => ['name' => @account_name, 'currency' => @account_currancy, 'balance' => @account_balance, 'nature' => @account_nature, 'transactions' => [trans]] }

      File.open('temp.json', 'a') do |file|
        file.puts JSON.pretty_generate(json_out)
      end
    end
  end
end
