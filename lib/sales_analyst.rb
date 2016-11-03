class SalesAnalyst
  attr_reader :se,
              :merchants_items,
              :std_deviation,
              :high_item_merchants,
              :merchant_average_price
  def initialize(sales_engine)
    @se = sales_engine
    @merchants_items = {}
    @std_deviation
    @high_item_merchants = []
    @merchant_average_price = merchant_average_price
  end

  def average_items_per_merchant
      items = se.items.all.count.to_f
      merchants = se.merchants.all.count.to_f
      (items / merchants).round(2)
  end


  def items_per_merchant
    #group_by might be a better way to do this
    se.merchants.all.map do |merchant|
      @merchants_items.store(merchant.id, se.items.find_all_by_merchant_id(merchant.id))
    end
  end

  def average_items_per_merchant_standard_deviation
    step_1 = std_deviation_denominator / (se.merchants.all.count - 1)
    @std_deviation = Math.sqrt(step_1).round(2)
  end

  def number_items_per_merchant
    # think this could be done using count enumerable
    items_per_merchant.map do |merchant|
      merchant.count
    end
  end

  def std_deviation_denominator
    number_items_per_merchant.map do |num|
      (num - average_items_per_merchant) ** 2
    end.reduce(:+)
  end

  def merchants_with_high_item_count
    average_items_per_merchant_standard_deviation
    merchants_items.map do |merchant|
      if merchant[1].count >  std_deviation
        @high_item_merchants << merchant[0]
      end
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    prices = items.map do |item|
      item.unit_price
    end
    @merchant_average_price = (prices.reduce(:+) / prices.count).round(2)
  end

  def average_price_of_items
    prices = se.items.all.map do |item|
      item.unit_price
    end
    (prices.reduce(:+) / prices.count).to_f
  end

  def golden_items
    se.items.all.find_all do |item|
      item.unit_price.to_f > (average_price_of_items * 2)
    end
  end

end
