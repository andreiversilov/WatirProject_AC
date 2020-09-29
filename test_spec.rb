# frozen_string_literal: true

require 'rspec'
require_relative 'task'
require 'watir'
require 'selenium-webdriver'
require 'nokogiri'
require 'open-uri'

$global_currency = ''
$global_numberOfTransactions = 0

$account_user = Account.new
$account_user.set_all_UserInfo

describe 'Account' do
  it 'should get fixed value' do
    expect($account_user.numberOfTr).to eq 99
    expect(['$', '€', '¥', '₽', '£', '₴'].should(include($account_user.currency_account)))
    expect($account_user.currency_account).to eq '$'
    expect($account_user.balance_account).to eq '2,082.90'
    expect($account_user.nature_account).to eq 'Demo Everyday Account'

    $global_currency = $account_user.currency_account.to_s
    $global_numberOfTransactions = $account_user.numberOfTr
  end
end

describe 'Transactions' do
  it ' should get fixed value' do
    trans_user = Transactions.new
    for j in 0..$global_numberOfTransactions - 1
      trans_user.set_allDataTr($account_user.transactions_account[j], $account_user)
      expect(trans_user.currency).to eq $global_currency
    end
  end
end
