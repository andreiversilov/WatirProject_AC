class Account
  attr_accessor :user_name, :currency_account, :balance_account
  attr_accessor :type_account, :transactions_account, :tr_count, :count

  def initialize(html)
    @count                = html.css("li[data-semantic = 'account-item']").size
    world_currency        = { '$' => 'USD', '€' => 'EUR', '₽' => 'RUB' }
    @user_name            = html.css('h6.grouped-list__group__heading').first.text
    @currency_account     = world_currency[html.css("span[data-semantic = 'available-balance']").text[0]]
    @balance_account      = html.css("span[data-semantic = 'available-balance']").text[1..-1].tr(',', '').to_f
    @type_account         =  html.css('div.css-aralps')[0].text
    @transactions_account = []

    arr_Signs = []

    list_trans = html.css('li.grouped-list__group')

    doc = html.css('li.grouped-list__group')[2..-1]
    (0..doc.css('path').size - 1).each do |i|
      arr_Signs.push('+') if doc.css('path')[i]['d'][0..2] == 'M5 '
      arr_Signs.push('-') if doc.css('path')[i]['d'][0..2] == 'M2 '
    end

    @tr_count = 0
#NOTE:processing of transactions in account.rb was needed in the early technical task
    html.css('li.grouped-list__group')[2..-1].each do |_li|
      tr_string = _li.text
      (0.._li.text.scan('Balance after transaction').size - 1).each do |_j|
        @transactions_account.push(_li.css('h3').text)
        @transactions_account[-1] += "\n"
        @transactions_account[-1] += html.css('h2.panel__header__label__primary')[@tr_count].text + "\n"
        @transactions_account[-1] += arr_Signs[@tr_count]
        @tr_count += 1
        @transactions_account[-1] += tr_string.slice!(tr_string.index('$').to_i + 1..(tr_string.index('Balance').to_i - 1))
        tr_string.to_s.slice!(tr_string.index('$')..tr_string.index('$'))
        tr_string.to_s.slice!(tr_string.index('$')..tr_string.index('$'))
        tr_string.to_s.slice!(tr_string.index('Balance'))
      end
    end
  end

  def all_UserInfo
    json_out = { 'name' => @user_name, 'currency' => @currency_account, 'balance' => @balance_account, 'nature' => @type_account, 'transactions' => @transactions_account }
  end

  def account_data
    data = { 'name' => @type_account, 'currency' => @currency_account, 'balance' => @balance_account, 'nature' => 'account' }
  end
end
