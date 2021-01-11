class Transactions
  attr_accessor :date, :description, :amount, :currency, :type_account
  attr_accessor :signs, :tr_count
  def initialize(html)
    world_currency = { '$' => 'USD', '€' => 'EUR', '₽' => 'RUB' }
    @date          = []
    @signs         = []
    @currency      = []
    @amount        = []
    @description   = []
    @type_account  = html.css('h2.css-1nuwk6t').text
    @tr_count      = 0

    (0..html.css('path').size - 1).each do |i|
      @signs.push('+') if html.css('path')[i]['d'][0..2] == 'M5 '
      @signs.push('-') if html.css('path')[i]['d'][0..2] == 'M2 '
    end

    html.css('li.grouped-list__group')[0..-1].each do |_li|
      tr_string = _li.text
      (0.._li.text.scan('Balance after transaction').size - 1).each do |_j|
        @date.push(date_handling(_li.css('h3').text))
        @description.push(_li.css('h2.panel__header__label__primary')[_j].text)
        @currency.push(world_currency[html.css("span[data-semantic = 'amount']")[@tr_count].text[0]])
        @amount.push(@signs[@tr_count].to_s)
        @amount[-1] += html.css("span[data-semantic = 'amount']")[@tr_count].text[1..-1]
        @amount[-1] = @amount[-1].tr(',', '').to_f
        @tr_count += 1 # the loop is non-linear and containing a nested loop, so an iterator is needed
      end
    end
  end

  def date_handling(raw_date)
    mounts = { 'January' => '01', 'February' => '02', 'March' => '03', 'April' => '04', 'May' => '05',
               'June' => '06', 'July' => '07', 'August' => '08', 'September' => '09', 'October' => '10',
               'November' => '11', 'December' => '12' }
    year   = raw_date.to_s.slice!(-5..-1).strip
    number = raw_date.to_s.slice!(-3..-2).strip
    number.insert(0, '0') if number.size == 1
    mon  = raw_date.chop!.strip
    date = "#{year}-#{mounts[mon]}-#{number}"
  end

  def transactions_data
    all_transaction = []
    (0..@tr_count - 1).each do |i|
      trans = { 'date' => @date[i], 'description' => @description[i], 'amount' => @amount[i], 'currency' => @currency[i], 'account_name' => @type_account }
      all_transaction.push(trans)
    end
    all_transaction
  end
end
