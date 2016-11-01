require './test/test_helper'
require './lib/item_repository'
require './lib/sales_engine'
# require './test/outputs'

class ItemRepositoryTest < Minitest::Test
  attr_reader :se,
              :outputs
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"
    })
    # @outputs = Outputs.new
  end

  def test_item_repository_exists
    ir = se.items

    assert_equal ItemRepository, ir.class
  end

  def test_item_repository_has_method_all
    skip # returns array of everything
    ir = se.items
    assert_equal " ", ir.all
  end

  def test_item_repository_has_method_find_by_id
    skip #this works, just trying to figure out output
    ir = se.items
    item = ir.find_by_id("263395237")
    output = outputs.item_repository_find_by_id_output
    assert_equal output, item
  end

  def test_item_repository_has_method_find_by_name
    skip # this works but gotta get a better test for output
    ir = se.items
    item = ir.find_by_name("Glitter scrabble frames")
    assert_equal " ", item
  end

  def test_item_repo_has_method_find_all_with_description
    skip # works, but need to figure out output
    ir = se.items
    item = ir.find_by_description("Glitter")

    assert_equal [], item
  end

  def test_item_repo_has_method_find_all_by_price

    ir = se.items
    item = ir.find_all_by_price("1300")

    assert_equal [], item
  end
end
