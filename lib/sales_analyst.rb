class SalesAnalyst
  attr_reader :se,
              :merchants_items,
              :average
  def initialize(sales_engine)
    @se = sales_engine
    @merchants_items = {}
    @average = average
  end

  def average_items_per_merchant
      items = se.items.all.count.to_f
      merchants = se.merchants.all.count.to_f
      @average = (items / merchants)
      average.round(2)
  end


  def items_per_merchant
    merchants = se.merchants.all
    merchants.map do |merchant|
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
    step_3 = step_2 / se.merchants.all.count - 1
    step_4 = Math.sqrt(step_3)
  end

end
