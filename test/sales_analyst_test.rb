require_relative '../test/test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :se,
              :sa
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small/items.csv",
      :merchants => "./data/small/merchants.csv",
      :invoices  => "./data/small/invoices.csv",
      :invoice_items => "./data/small/invoices.csv",
      :transactions => "./data/small/transactions.csv",
      :customers => "./data/small/customers.csv"})
  end

  def test_sales_analyst_exists
    sa = SalesAnalyst.new(se)
    assert_equal SalesAnalyst, sa.class
  end

  def test_find_total_revenue_by_date
    sa = SalesAnalyst.new(se)
    assert_equal 0, sa.total_revenue_by_date(Time.parse("2009-12-09"))
  end

  def test_item_count
    sa = SalesAnalyst.new(se)
    assert_equal 42, sa.item_count
  end

  def test_it_knows_the_number_of_merchants
    sa = SalesAnalyst.new(se)
    assert_equal 30, sa.merchant_count
  end

  def test_returns_merchants_with_only_one_item_registered_in_a_named_month
    sa = SalesAnalyst.new(se)
    assert_equal 2, sa.merchants_with_only_one_item_registered_in_month("March").count
    assert_equal 1, sa.merchants_with_only_one_item_registered_in_month("January").count
  end

  def test_returns_top_earners_by_input
    sa = SalesAnalyst.new(se)
    assert_equal 2, sa.top_revenue_earners(2).length
    assert_equal 10, sa.top_revenue_earners(10).length
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant
    sa = SalesAnalyst.new(se)
    average = sa.average_items_per_merchant
    assert_equal 1.4, average
  end

  def test_can_find_the_number_of_items_for_each_merchant
    sa = SalesAnalyst.new(se)
    sa.items_per_merchant
    assert_equal 1, sa.merchants_items[12334141].count
  end

  def test_sa_can_calculate_average_items_per_merchant_standard_deviation
    sa = SalesAnalyst.new(se)
    sa.items_per_merchant
    assert_equal 2.33, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    sa = SalesAnalyst.new(se)
    assert_equal 1, sa.merchants_with_high_item_count.count
  end

  def test_merchants_with_high_item_count_returns_array
    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.merchants_with_high_item_count
  end

  def test_find_the_average_item_price_for_a_merchant
    sa = SalesAnalyst.new(se)
    bigdecimal_price = sa.average_item_price_for_merchant(12334141)
    assert_equal 12.0, bigdecimal_price
    assert_instance_of BigDecimal, bigdecimal_price
  end

  def test_find_the_average_price_of_items
    sa = SalesAnalyst.new(se)
    assert_equal 170.37, sa.average_price_of_items.round(2)
  end

  def test_average_average_price_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"})
    sa = SalesAnalyst.new(se)
    average_average = sa.average_average_price_per_merchant
    assert_equal 350.29, average_average
  end

  def test_which_are_our_golden_items
    sa = SalesAnalyst.new(se)
    golden_items_collection = sa.golden_items
    assert_instance_of Item, golden_items_collection[0]
    assert_equal 5, golden_items_collection.count
  end

  def test_returns_merchants_with_only_one_item_registered_in_a_named_month
    sa = SalesAnalyst.new(se)
    expected = sa.merchants_with_only_one_item_registered_in_month(10)
    assert_instance_of Array, expected
  end

  def test_returns_merchants_with_only_one_item
    sa = SalesAnalyst.new(se)
    assert_instance_of Array, sa.merchants_with_only_one_item
    assert_equal 6, sa.merchants_with_only_one_item.count
  end

  def test_merchants_with_pending_invoices
    sa = SalesAnalyst.new(se)
    assert_instance_of Array, sa.merchants_with_pending_invoices
    assert_equal 2, sa.merchants_with_pending_invoices.count
  end

  def test_mrchants_ranked_by_revenue
    sa = SalesAnalyst.new(se)

    assert_equal "Shopin1901", sa.merchants_ranked_by_revenue.first.name
  end

  def test_average_invoices_per_day
    sa = SalesAnalyst.new(se)

    assert_equal 4.86, sa.average_invoices_per_day.round(2)
  end

  def test_standard_deviation_of_invoices_per_day
    sa = SalesAnalyst.new(se)

    assert_equal 2.41, sa.standard_deviation_of_invoices_per_day
  end

end
