require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
  end

  def test_item_repository_exists
    ir = se.items

    assert_equal ItemRepository, ir.class
  end
end
