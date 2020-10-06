# frozen_string_literal: true

require 'rspec'
require_relative 'task'
require 'watir'
require 'selenium-webdriver'
require 'nokogiri'
require 'open-uri'

describe 'Account' do
  it 'check number of accounts and show an example account' do
    bank = ExampleBank.new
    html = Nokogiri::HTML(File.read('account.html'))
    accounts = bank.parse_accounts(html)
    transaction = Transactions.new(accounts)
    expect(accounts.count).to eq(5)

    expect(transaction.count).to eq(99)
    expect(transaction.trans_output_json[0]).to eq(
      {
        'amount' => 50.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[1]).to eq(
      {
        'amount' => -37.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[2]).to eq(
      {
        'amount' => 49.9,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[3]).to eq(
      {
        'amount' => -220.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[4]).to eq(
      {
        'amount' => -160.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[5]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[6]).to eq(
      {
        'amount' => 100.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[7]).to eq(
      {
        'amount' => 83.5,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[8]).to eq(
      {
        'amount' => 41.4,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[9]).to eq(
      {
        'amount' => 4550.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[10]).to eq(
      {
        'amount' => 46.3,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[11]).to eq(
      {
        'amount' => 150.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[12]).to eq(
      {
        'amount' => 57.3,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[13]).to eq(
      {
        'amount' => -32.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[14]).to eq(
      {
        'amount' => 50.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[15]).to eq(
      {
        'amount' => 91.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[16]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[17]).to eq(
      {
        'amount' => 200.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[18]).to eq(
      {
        'amount' => -29.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[19]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[20]).to eq(
      {
        'amount' => -96.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[21]).to eq(
      {
        'amount' => 4550.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[22]).to eq(
      {
        'amount' => 69.5,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[23]).to eq(
      {
        'amount' => 100.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[24]).to eq(
      {
        'amount' => -2439.2,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[25]).to eq(
      {
        'amount' => 85.4,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[26]).to eq(
      {
        'amount' => -306.5,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[27]).to eq(
      {
        'amount' => -69.9,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[28]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[29]).to eq(
      {
        'amount' => 15.9,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[30]).to eq(
      {
        'amount' => -24.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[31]).to eq(
      {
        'amount' => 100.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[32]).to eq(
      {
        'amount' => 200.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[33]).to eq(
      {
        'amount' => 150.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[34]).to eq(
      {
        'amount' => -240.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[35]).to eq(
      {
        'amount' => -190.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[36]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[37]).to eq(
      {
        'amount' => 12.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[38]).to eq(
      {
        'amount' => 100.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[39]).to eq(
      {
        'amount' => 50.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[40]).to eq(
      {
        'amount' => 4550.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[41]).to eq(
      {
        'amount' => -83.7,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[42]).to eq(
      {
        'amount' => -20.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[43]).to eq(
      {
        'amount' => -23.8,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[44]).to eq(
      {
        'amount' => -18.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[45]).to eq(
      {
        'amount' => 100.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[46]).to eq(
      {
        'amount' => 96.7,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[47]).to eq(
      {
        'amount' => 72.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[48]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[49]).to eq(
      {
        'amount' => 98.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[50]).to eq(
      {
        'amount' => 5.4,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[51]).to eq(
      {
        'amount' => 85.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[52]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[53]).to eq(
      {
        'amount' => -86.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[54]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[55]).to eq(
      {
        'amount' => 56.8,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[56]).to eq(
      {
        'amount' => 4550.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[57]).to eq(
      {
        'amount' => 42.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[58]).to eq(
      {
        'amount' => 50.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[59]).to eq(
      {
        'amount' => 100.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[60]).to eq(
      {
        'amount' => 96.3,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[61]).to eq(
      {
        'amount' => 97.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[62]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[63]).to eq(
      {
        'amount' => -69.9,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[64]).to eq(
      {
        'amount' => -34.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[65]).to eq(
      {
        'amount' => 14.5,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[66]).to eq(
      {
        'amount' => -97.3,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[67]).to eq(
      {
        'amount' => 75.2,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[68]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[69]).to eq(
      {
        'amount' => 74.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[70]).to eq(
      {
        'amount' => 37.5,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[71]).to eq(
      {
        'amount' => 4550.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[72]).to eq(
      {
        'amount' => -400.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[73]).to eq(
      {
        'amount' => -120.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[74]).to eq(
      {
        'amount' => -22.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[75]).to eq(
      {
        'amount' => 87.4,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[76]).to eq(
      {
        'amount' => 39.4,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[77]).to eq(
      {
        'amount' => -10.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[78]).to eq(
      {
        'amount' => 36.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[79]).to eq(
      {
        'amount' => 67.6,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[80]).to eq(
      {
        'amount' => 200.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[81]).to eq(
      {
        'amount' => 100.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[82]).to eq(
      {
        'amount' => -39.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[83]).to eq(
      {
        'amount' => 4550.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[84]).to eq(
      {
        'amount' => 200.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[85]).to eq(
      {
        'amount' => -29.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[86]).to eq(
      {
        'amount' => 53.7,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[87]).to eq(
      {
        'amount' => 31.8,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[88]).to eq(
      {
        'amount' => 49.9,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[89]).to eq(
      {
        'amount' => 41.2,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[90]).to eq(
      {
        'amount' => 4.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[91]).to eq(
      {
        'amount' => -69.9,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[92]).to eq(
      {
        'amount' => 200.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[93]).to eq(
      {
        'amount' => 60.8,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[94]).to eq(
      {
        'amount' => -83.7,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[95]).to eq(
      {
        'amount' => 4550.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[96]).to eq(
      {
        'amount' => -13.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[97]).to eq(
      {
        'amount' => -200.0,

        'currency' => 'USD'
      }
    )
    expect(transaction.trans_output_json[98]).to eq(
      {
        'amount' => -50.0,

        'currency' => 'USD'
      }
    )
  end
end
