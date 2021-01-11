require 'watir'
require 'selenium-webdriver'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'byebug'
require 'pry'
require_relative 'account.rb'
require_relative 'transactions.rb'

class ExampleBank
  attr_accessor :browser, :account, :transactions
  def execute
    connect

    fetch_accounts

    fetch_transactions

    save_json
  end

  def connect
    @browser = Watir::Browser.new :firefox
    @browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
    (@browser.button value: 'personal').click
    @browser.execute_script('window.scrollBy(0,4500)')
    sleep 5
    @browser.execute_script('window.scrollBy(0,4500)')
    sleep 5
    @browser.execute_script('window.scrollBy(0,4500)')
    sleep 5
    @browser.execute_script('window.scrollBy(0,4500)')
    sleep 5
    @browser
  end

  def fetch_accounts
    html_account = Nokogiri::HTML.fragment(@browser.div(class: 'content__wrapper').html)
    parse_accounts(html_account)
  end

  def fetch_transactions
    html_transactions = Nokogiri::HTML.fragment(@browser.div(class: 'content__inner').html)
    parse_transactions(html_transactions)
  end

  def parse_accounts(html_account)
    @account      = Account.new(html_account)
    @account_data = account.account_data
  end

  def parse_transactions(html_transactions)
    @transactions      = Transactions.new(html_transactions)
    @transactions_data = transactions.transactions_data
  end

  def save_json
    File.open('temp.json', 'a') do |file|
      (0..@transactions_data.size - 1).each do |i|
        @account_data['transactions'] = [@transactions_data[i]]
        output_json                   = { 'account' => [@account_data] }
        file.puts JSON.pretty_generate(output_json)
        @account_data.delete('transactions')
      end
    end
  end
end

