require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_reads_from_csv_files
    se = SalesEngine.from_csv({:items =>"./data/small/items.csv"})

    assert_equal "263395237", se[0][:id]
  end

  def test_reads_multiple_merchants_and_rows_from_csv_file
    se = SalesEngine.from_csv({:items =>"./data/small/items.csv"})

    assert_equal "Glitter scrabble frames", se[1][:name]
  end

  def test_reads_from_merchant_csv_files
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv"})

    assert_equal "12334105", se[0][:id]
  end
end
