require './test/test_helper'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"
    })
  end

  def test_item_repository_exists
    ir = se.items

    assert_equal ItemRepository, ir.class
  end

  def test_item_repository_has_method_all
    skip
    ir = se.items
    assert_equal " ", ir.all
  end

  def test_item_repository_has_method_find_by_id
    ir = se.items
    item = ir.find_by_id(263395237)
    assert_equal 263395237, item
  end
end
