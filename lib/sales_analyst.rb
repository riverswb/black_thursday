class SalesAnalyst
  attr_reader :se
  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
      items = se.items.all.count.to_f
      merchants = se.merchants.all.count.to_f
      (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    # so I've been doing this completely wrong
    items = se.items.all.count.to_f
    merchants = se.merchants.all.count.to_f
    mean = (items / merchants)
    items_index = []
    se.items.all.each_with_index do |item, index|
      items_index << index
    end
    step_1 = items_index.map do |item|
      (item - mean) ** 2
      end
    end

  end
end
