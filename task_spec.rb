require 'rspec'
require_relative 'task'
require 'watir'
require 'selenium-webdriver'
require 'nokogiri'
require 'open-uri'

describe 'ExampleBank' do
  it 'check number of accounts and show an example account' do
    bank = ExampleBank.new
    bank.connect
    accounts = bank.fetch_accounts

    expect(accounts.count).to eq(5)

    expect(accounts.account_data.to_hash).to eq(
      {
        'name'     => 'Demo Everyday Account',
        'currency' => 'USD',
        'balance'  => 2082.90,
        'nature'   => 'account'
      }
    )

    transaction = bank.fetch_transactions
    expect(transaction.tr_count).to eq(99)
    expect(transaction.transactions_data[0]).to eq(
      {
        'date'         => '2020-10-11',
        'description'  => 'Withdrawal - Non BBL ATMCashcard\\Newsxpress Beers Port / 2356',
        'amount'       => 50.0,
        'currency'     => 'USD',
        'account_name' => 'Demo Everyday Account'
      }
    )
  end
end
