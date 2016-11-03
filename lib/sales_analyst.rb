class SalesAnalyst
  attr_reader :se,
              :merchants_items,
              :average,
              :std_deviation,
              :high_item_merchants,
              :merchant_average_price
  def initialize(sales_engine)
    @se = sales_engine
    @merchants_items = {}
    @average = average
    @std_deviation
    @high_item_merchants = []
    @merchant_average_price = merchant_average_price
  end

  def average_items_per_merchant
      items = se.items.all.count.to_f
      merchants = se.merchants.all.count.to_f
      @average = (items / merchants)
      average.round(2)
  end


  def items_per_merchant
    #group_by might be a better way to do this
    se.merchants.all.map do |merchant|
      merchants_items.store(merchant.id, se.items.find_all_by_merchant_id(merchant.id))
    end
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant
    number_items_per_merchant = @merchants_items.map do |merchant|
      merchant[1].count
    end
    step_1 = number_items_per_merchant.map do |num|
      (num - average) ** 2
    end
    step_2 = step_1.reduce(:+)
    step_3 = step_2 / (se.merchants.all.count - 1)
    @std_deviation = Math.sqrt(step_3).round(2)
  end

  def merchants_with_high_item_count
    items_per_merchant
    average_items_per_merchant_standard_deviation
    merchants_items.map do |merchant|
      if merchant[1].count >  std_deviation
        @high_item_merchants << merchant[0]
      end
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    prices = items.map do |item|
      item.unit_price
    end
    @merchant_average_price = prices.reduce(:+) / prices.count
  end

  def average_price_of_items
    prices = se.items.all_items.map do |item|
      item.unit_price
    end

    (prices.reduce(:+) / prices.count).to_f
  end

  def golden_items
    se.items.all_items.find_all do |item|
      item.unit_price.to_f > (average_price_of_items * 2)
    end
  end

end
