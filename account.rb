# frozen_string_literal: true

class Account
  attr_accessor :name_account, :currency_account, :balance_account
  attr_accessor :nature_account, :transactions_account, :numberOfTr, :count

  def initialize(html)
    @count = html.css("li[data-semantic = 'account-item']").size
    world_currency = { '$' => 'USD', '€' => 'EUR', '₽' => 'RUB' }
    @name_account = html.css('h6.grouped-list__group__heading').first.text
    @currency_account = world_currency[html.css("span[data-semantic = 'header-available-balance-amount']").text[0]]
    @balance_account = html.css("span[data-semantic = 'header-available-balance-amount']").text[1..-1].tr(',', '').to_f
    @nature_account =  html.css('div.css-aralps')[0].text
    @transactions_account = []

    system('cls')

    arrayOfSigns = []

    list_trans = html.css('li.grouped-list__group')

    doc = html.css('li.grouped-list__group')[2..-1]
    (0..doc.css('path').size - 1).each do |i|
      arrayOfSigns.push('+') if doc.css('path')[i]['d'][0..2] == 'M5 '
      arrayOfSigns.push('-') if doc.css('path')[i]['d'][0..2] == 'M2 '
    end

    @numberOftr = 0

    html.css('li.grouped-list__group')[2..-1].each_with_index do |_li, i|
      stringOftr = html.css('li.grouped-list__group')[2..-1][i].text
      (0..html.css('li.grouped-list__group')[2..-1][i].text.scan('Balance after transaction').size - 1).each do |_j|
        @transactions_account.push(html.css('li.grouped-list__group')[2..-1][i].css('h3').text)
        @transactions_account[-1] += "\n"
        @transactions_account[-1] += html.css('h2.panel__header__label__primary')[@numberOftr].text + "\n"
        @transactions_account[-1] += arrayOfSigns[@numberOftr]
        @numberOftr += 1
        @transactions_account[-1] += stringOftr.slice!(stringOftr.index('$').to_i + 1..(stringOftr.index('Balance').to_i - 1))
        stringOftr.to_s.slice!(stringOftr.index('$')..stringOftr.index('$'))
        stringOftr.to_s.slice!(stringOftr.index('$')..stringOftr.index('$'))
        stringOftr.to_s.slice!(stringOftr.index('Balance'))
      end
    end
  end

  def get_all_UserInfo
    json_out = { 'name' => @name_account, 'currency' => @currency_account, 'balance' => @balance_account, 'nature' => @nature_account, 'transactions' => @transactions_account }
  end
end
