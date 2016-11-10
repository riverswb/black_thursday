require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst
  attr_reader :se,
              :merchants_items,
              :invoice_items

  def initialize(se)
    @se = se
    @merchants_items = {}
  end

  def item_count
    se.item_count
  end

  def merchants_with_only_one_item_registered_in_month(month)
    se.merchants.all.select do |merchant|
      merchant_items = se.items.find_all_by_merchant_id(merchant.id)
      merchant_items.count == 1 && merchant.created_at.strftime("%B") == month
    end
  end

  def best_item_for_merchant(merchant_id)
    our_merchant = all_merchants.find do |merchant|
      merchant.id.to_i == merchant_id
    end
    best_paid_invoices(our_merchant)
  end

  def best_paid_invoices(our_merchant)
    found = our_merchant.invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
    best_paid_invoice_items(found)
  end

  def best_paid_invoice_items(paid_invoices)
    found = paid_invoices.flat_map do |invoice|
      invoice.invoice_items
    end
    best_items(found)
  end

  def best_items(paid_invoice_items)
    items = paid_invoice_items.group_by do |item|
      item.item_id.to_i
      end
    best_reduced(items)
  end

  def best_reduced(items)
    reduced = Hash.new{0}
    items.each do |key, value|
      reduced[key] =
      value.reduce(0){ |total, value| total +=(value.unit_price*value.quantity)}
      end
    best_max(reduced)
  end

  def best_max(reduced)
    max = reduced.values.max
    almost_done = reduced.select do |key,value|
      key if value == max
    end
    all_items.find do |item|
    almost_done.keys.first == item.id
    end
  end

  def all_items
    se.all_items
  end

  def most_sold_item_for_merchant(merchant_id)
    our_merchant = all_merchants.find do |merchant|
      merchant.id.to_i == merchant_id
    end
    most_paid_invoices(our_merchant)
  end

  def most_paid_invoices(our_merchant)
    paid_invoices = our_merchant.invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
    most_paid_invoice_items(paid_invoices)
  end

  def most_paid_invoice_items(paid_invoices)
    found = paid_invoices.flat_map do |invoice|
      invoice.invoice_items
    end
    most_items(found)
  end

  def most_items(paid_invoice_items)
    items = paid_invoice_items.group_by do |item|
      item.item_id.to_i
    end
    most_reduced(items)
  end

  def most_reduced(items)
    reduced = Hash.new{0}
    items.each do |key, value|
      reduced[key] = value.reduce(0){ |total, sumtin| total += sumtin.quantity}
    end
    most_max(reduced)
  end

  def most_max(reduced)
    max = reduced.values.max
    almost_done = reduced.select do |key,value|
      key if value == max
    end
    almost_done.keys.map do |key|
      all_items.find {|item| item.id == key}
    end
  end

  def merchants_with_only_one_item
    se.merchants.all.select do |merchant|
      merchant_items = se.items.find_all_by_merchant_id(merchant.id)
      merchant_items.count == 1
    end
  end

  def merchants_with_pending_invoices
    all_merchants.find_all do |merchant|
      merchant.invoices.any? do |invoice|
          invoice.pending?
      end
    end
  end

  def merchants_ranked_by_revenue
    all_merchants.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end.reverse
  end

  def revenue_by_merchant(merchant_id)
    merchants_invoices = se.find_all_invoices_by_merchant_id(merchant_id)
    merchants_invoices.reduce(0) do |revenue, invoice|
      revenue += invoice.total if invoice.is_paid_in_full?
      revenue
    end
  end

  def top_revenue_earners(top_amount=20)
    real_dealers = all_merchants.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end
    real_dealers.last(top_amount).reverse
  end

  def total_revenue_by_date(date_input)
    invoices = find_invoices_by_date(date_input)
    invoice_items = invoices.map do |invoice|
      invoice.invoice_items
    end
    invoice_items.flatten!
    invoice_items.reduce(0) do |total, n|
      total += ( n.unit_price * n.quantity)
    end
  end

  def find_invoices_by_date(date_input)
    se.find_invoices_by_date(date_input)
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
      merchant_invoice_count(merchant.id) > ((standard_deviation * 2) + average)
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
      merchants_items[merchant.id] = items
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
      se.find_merchant_by_id(merchant_id[0])
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
    avg_prices = prices.flatten.reduce(0) {|sum,num| sum += num.to_f}
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
