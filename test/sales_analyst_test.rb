require_relative '../test/test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
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

    assert_equal [], sa.items_per_merchant
  end

  def test_sa_can_calculate_average_items_per_merchant_standard_deviation
    skip
    sa = SalesAnalyst.new(se)
    assert_equal 0, sa.average_items_per_merchant_standard_deviation
  end

end
