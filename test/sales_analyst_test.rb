require_relative '../test/test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"
    })
  end

  def test_sales_anallyst_exists
    sa = SalesAnalyst.new(se)
    assert_equal SalesAnalyst, sa.class
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sa = SalesAnalyst.new(se)
    average = sa.average_items_per_merchant
    assert_equal 2.88, average
  end


  def test_can_find_the_number_of_items_for_each_merchant
    sa = SalesAnalyst.new(se)
    sa.items_per_merchant
    assert_equal 1, sa.merchants_items[12334141].count
  end

  def test_sa_can_calculate_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sa = SalesAnalyst.new(se)
    sa.items_per_merchant
    # 3.26
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sa = SalesAnalyst.new(se)
    sa.merchants_with_high_item_count
    assert_equal 114, sa.high_item_merchants.count
  end

  def test_find_the_average_item_price_for_a_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sa = SalesAnalyst.new(se)

    bigdecimal_price = sa.average_item_price_for_merchant(12334141)
    assert_equal 12.0, bigdecimal_price.to_f
    assert_instance_of BigDecimal, bigdecimal_price
  end

  def test_find_the_average_price_of_items
    e = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 12.5, sa.average_price_of_items
  end

  def test_which_are_our_golden_items

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    sa = SalesAnalyst.new(se)
    golden_items_collection = sa.golden_items
    assert_instance_of Item, golden_items_collection[0]
    assert_equal 84, golden_items_collection.count
  end
end
