require 'bigdecimal'
require 'bigdecimal/util'
class SalesAnalyst
  attr_reader :se,
              :merchants_items
  def initialize(sales_engine)
    @se = sales_engine
    @merchants_items = {}
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
    step_1 = std_deviation_numerator / (se.merchants.all.count - 1)
    Math.sqrt(step_1).round(2)
  end

  def number_items_per_merchant
    # think this could be done using count enumerable
    items_per_merchant.map do |merchant|
      merchant.count
    end
  end

  def std_deviation_numerator
    number_items_per_merchant.map do |num|
      (num - average_items_per_merchant) ** 2
    end.reduce(:+)
  end

  def merchants_with_high_item_count
    std_deviation = average_items_per_merchant_standard_deviation
    high_item_merchants_ids = []
    average_items_per_merchant_standard_deviation
    @merchants_items.find_all do |merchant|
      if merchant[1].count >  (std_deviation + average_items_per_merchant)
        high_item_merchants_ids << merchant[0]
      end
    end
    high_item_merchants_ids.map do |merchant_id|
      se.find_merchant_by_id(merchant_id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    prices = items.map do |item|
      item.unit_price
    end
    (prices.reduce(:+) / prices.count).round(2)
  end

  def average_price_of_items
    prices = se.items.all.map do |item|
      item.unit_price
    end
    (prices.reduce(:+) / prices.count).to_f
  end

  def avg_avg_setup(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    prices = items.map do |item|
      item.unit_price
    end
    merchant_avg_avg = []
    merchant_avg_avg << (prices.reduce(:+) / prices.count).round(2)
  end

  def average_average_price_per_merchant
    prices = se.merchants.all.map do |merchant|
      avg_avg_setup(merchant.id)
    end
    avg_prices = prices.flatten.reduce(0) do |sum,num|
      sum += num.to_f
      sum
    end
    (avg_prices / se.merchants.all.count).round(2).to_d
  end

  def item_std_deviation
    denominator = se.items.all.count - 1
    Math.sqrt(item_std_dev_numerator / denominator).round(2)
  end

  def item_std_dev_numerator
    se.items.all.reduce(0) do |sum, num|
      sum += (num.unit_price_to_dollars - average_price_of_items) ** 2
      sum
    end

  end
  def golden_items
    i_std_dev = item_std_deviation
    se.items.all.find_all do |item|
      item.unit_price_to_dollars >  (average_price_of_items  + (2 * i_std_dev))
    end
  end
end
