require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    se = SalesEngine.new

    assert_equal SalesEngine, se.class
  end

  def test_sales_engine_reads_from_csv_files
    se = SalesEngine.from_csv({
      :items     =>"./data/items.csv",
      :merchants =>"./data/merchants.csv",
      })


  end

end
