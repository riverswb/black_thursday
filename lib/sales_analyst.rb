require 'bigdecimal'
require 'bigdecimal/util'
class SalesAnalyst
  attr_reader :se,
              :merchants_items
  def initialize(se)
    @se = se
    @merchants_items = {}
  end

  def invoice_status(status_input)
    count = se.all_invoices.find_all do |invoice|
      invoice.status == status_input
    end
    ((count.length.to_f/invoice_count)*100).round(2)
  end

  def average_invoices_per_day
    invoice_count/7.0
  end

  def standard_deviation_of_invoices_per_day
    total = number_of_invoices_per_given_day.map do |day, count|
      (count - average_invoices_per_day)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2)
  end

  def days_invoices_were_created
    se.all_invoices.map do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def top_days_by_invoice_count
    days = number_of_invoices_per_given_day
    standard_deviation = standard_deviation_of_invoices_per_day
    average = average_invoices_per_day
    days.select do |day, count|
      day if count > (standard_deviation + average)
    end.keys
  end

  def number_of_invoices_per_given_day
    invoices_per_day = Hash.new 0
    days_invoices_were_created.each do |day|
      invoices_per_day[day] += 1
    end
    invoices_per_day
  end

  def bottom_merchants_by_invoice_count
    standard_deviation = average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
        all_merchants.find_all do |merchant|
      merchant_invoice_count(merchant.id) < ((-standard_deviation *2) + average)
    end
  end

  def top_merchants_by_invoice_count
    standard_deviation = average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    all_merchants.find_all do |merchant|
      merchant_invoice_count(merchant.id) > ((standard_deviation *2) + average)
    end
  end

  def merchant_invoice_count(merchant_id)
    se.find_invoices_by_merchant_id(merchant_id).count
  end

  def average_invoices_per_merchant_standard_deviation
    total = all_merchants.map do |merchant|
      ((merchant_invoice_count(merchant.id)) - average_invoices_per_merchant)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2)
  end

  def all_merchants
    se.all_merchants
  end

  def average_invoices_per_merchant
    (invoice_count/merchant_count.to_f).round(2)
  end

  def invoice_count
    se.invoice_count
  end

  def merchant_count
    se.merchant_count
  end

  def average_items_per_merchant
    items = se.items.all.count
    merchants = se.merchants.all.count.to_f
    (items / merchants).round(2)
  end

  def items_per_merchant
    se.merchants.all.map do |merchant|
      items = se.items.find_all_by_merchant_id(merchant.id)
      @merchants_items[merchant.id] = items
    end
  end

  def average_items_per_merchant_standard_deviation
    step_1 = std_deviation_numerator / (se.merchants.all.count - 1)
    Math.sqrt(step_1).round(2)
  end

  def number_items_per_merchant
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
    high_item_merchants_ids.map do |merchant_id|
      se.find_merchant_by_id(merchant_id)
    end
  end

  def high_item_merchants_ids
    std_deviation = average_items_per_merchant_standard_deviation
    merchants_items.find_all do |merchant|
      merchant[1].count >  (std_deviation + average_items_per_merchant)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    prices = items.reduce(0) {|sum, num| sum += num.unit_price}
    (prices / items.count).round(2)
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
    (prices.reduce(:+) / prices.count).round(2)
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
