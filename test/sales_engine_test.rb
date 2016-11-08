require_relative '../test/test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({:items =>"../data/small/items.csv",
                               :merchants => "../data/small/merchants.csv"
                                })
    end

  def test_sales_engine_reads_from_item_csv_file
    assert_equal 12334141, se.items.all[0].merchant_id
  end

  def test_reads_multiple_items_and_rows_from_csv_file
    assert_equal "Glitter scrabble frames", se.items.all[1].name
  end

  def test_reads_from_merchant_csv_files
    assert_equal 12334105, se.merchants.all[0].id
  end

  def test_reads_multiple_merchants_and_rows_from_csv_file
    assert_equal "Shopin1901", se.merchants.all[0].name
    assert_equal "Candisart", se.merchants.all[1].name
  end


  def test_there_is_a_relationship_layer_for_merchants
    merchant = se.merchants.find_by_id(12334141)
    merchant.items
    assert_instance_of Array, merchant.items
  end

  def test_merchant_items_returns_an_instances_of_items
    skip
    merchant = se.merchants.find_by_id(12334141)
    merchant.items
    assert_instance_of Item, merchant.items
  end
  def test_merchants_and_items_are_linked_by_merchant_id
    skip
    se = SalesEngine.from_csv({:items =>"../data/items.csv",
      :merchants => "../data/small/merchants.csv"
      })
      merchant = se.merchants.find_by_id(12335971)
      item = se.items.find_by_id(merchant.id)
      binding.pry
      assert_equal Array, merchant.class
      assert_equal 1, merchant.items.length

      merchant = engine.merchants.find_by_id(id)
      expected = merchant.items
    end
end
