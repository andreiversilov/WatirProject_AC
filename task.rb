require 'watir'
require 'selenium-webdriver'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'byebug'
require_relative 'account.rb'
require_relative 'transactions.rb'

class ExampleBank
  def execute
    connect

    fetch_transactions(fetch_accounts)
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
    File.open('account.html', 'w') do |file|
      file.puts @browser.body(class: 'accounts accounts-index not-native-wrapped loaded').html
    end
  end

  def fetch_accounts
    html = Nokogiri::HTML.fragment(@browser.div(class: 'content__wrapper').html)

    parse_accounts(html)
  end

  def fetch_transactions(account)
    parse_transactions(account)
  end

  def parse_accounts(html)
    account = Account.new(html)
  end

  def parse_transactions(account)
    transactions = Transactions.new(account)
    transactions.general_output
  end
end

example = ExampleBank.new
example.execute
