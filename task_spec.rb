# frozen_string_literal: true

require 'rspec'
require_relative 'task'
require 'watir'
require 'selenium-webdriver'
require 'nokogiri'
require 'open-uri'

describe 'ExampleBank' do
  it 'check number of accounts and show an example account' do
    bank = ExampleBank.new
    html_account = Nokogiri::HTML(File.read('account.html'))
    html_transactions = Nokogiri::HTML(File.read('transactions.html'))
    accounts = bank.parse_accounts(html_account)

    expect(accounts.count).to eq(5)

    expect(accounts.data_account.to_hash).to eq(
      {
        "name" => "Demo Everyday Account",
        "currency" => "USD",
        "balance" => 2082.90,
        "nature" => "account",
        "transactions" => []
      }
    )


    accounts = bank.parse_accounts(html_transactions)
    transaction = Transactions.new(accounts)
    expect(transaction.count).to eq(99)
    expect(transaction.trans_output_json[0]).to eq(
      {
        "date" => "2020-10-07",
        "description" => "Withdrawal - Non BBL ATMCashcard\\Newsxpress Beers Port / 2356",
        "amount" => 50.0,
        "currency" => "USD",
        "account_name" => "Demo Everyday Account"

      }
    )

  end
end
