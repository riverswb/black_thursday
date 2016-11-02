require_relative '../test/test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_reads_from_item_csv_file
    se = SalesEngine.from_csv({:items =>"./data/small/items.csv",
                               :merchants => "./data/small/merchants.csv"
                                })

    assert_equal 12334141, se.items.all_items[0].merchant_id
  end

  def test_reads_multiple_items_and_rows_from_csv_file

    se = SalesEngine.from_csv({:items =>"./data/small/items.csv",
                               :merchants => "./data/small/merchants.csv"
                                })

    assert_equal "Glitter scrabble frames", se.items.all_items[1].name
  end

  def test_reads_from_merchant_csv_files
    se = SalesEngine.from_csv({:items =>"./data/small/items.csv",
                               :merchants => "./data/small/merchants.csv"
                                })
    assert_equal 12334105, se.merchants.all[0].id
  end

  def test_reads_multiple_merchants_and_rows_from_csv_file
    se = SalesEngine.from_csv({:items =>"./data/small/items.csv",
                               :merchants => "./data/small/merchants.csv"
                                })
    assert_equal "Shopin1901", se.merchants.all[0].name
    assert_equal "Candisart", se.merchants.all[1].name
  end

  def test_merchants_and_items_are_linked_by_merchant_id
    skip
    se = SalesEngine.from_csv({:items =>"./data/items.csv",
                               :merchants => "./data/small/merchants.csv"
                                })
    merchant = se.merchants.find_by_id(12334105)
    binding.pry

    item = se.items.find_by_id
  end
end
