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
  end

  def test_item_repository_exists
    ir = se.items
    assert_equal ItemRepository, ir.class
  end

  def test_item_repository_has_method_all
    ir = se.items
    assert_equal 2, ir.all.count
  end

  def test_item_repository_has_method_all_returns_array
    ir = se.items
    assert_equal Array, ir.all.class
  end

  def test_item_repository_has_method_find_by_id
    ir = se.items
    item = ir.find_by_id("263395237")
    assert_equal "263395237", item.id
  end

  def test_item_repository_find_by_id_returns_instance_of_item
    ir = se.items
    item = ir.find_by_id("263395237")
    assert_instance_of Item, item
  end

  def test_item_repository_find_by_id_returns_nil_if_not_present
    ir = se.items
    item = ir.find_by_id("2633957")
    assert_nil item
  end

  def test_item_repository_has_method_find_by_name
    ir = se.items
    item = ir.find_by_name("Glitter scrabble frames")
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_item_repository_has_method_find_by_name_is_case_insensitive
    ir = se.items
    item = ir.find_by_name("glitter Scrabble Frames")
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_item_repository_find_by_name_returns_instance_of_item
    ir = se.items
    item = ir.find_by_name("Glitter scrabble frames")
    assert_instance_of Item, item
  end

  def test_item_repository_find_by_name_returns_nil_if_not_found
    ir = se.items
    item = ir.find_by_name("Glitter frames")
    assert_nil item
  end

  def test_item_repo_has_method_find_all_with_description
    ir = se.items
    item = ir.find_by_description("Glitter")
    assert_equal "Glitter scrabble frames", item[0].name
  end

  def test_item_repo_find_all_with_description_returns_empty_array_if_not_found
    ir = se.items
    item = ir.find_by_description("Glittersdfsdf")
    assert_equal [], item
  end

  def test_item_repo_has_method_find_all_by_price
    ir = se.items
    item = ir.find_all_by_price("1300")
    assert_equal "1300", item[1].unit_price
  end

  def test_find_all_by_price_in_range
    ir = se.items
    item = ir.find_all_by_price_in_range("1100","1300")
    assert_equal "1200", item[0].unit_price
  end

  def test_item_repo_has_method_find_all_by_merchant_id
    ir = se.items
    item = ir.find_all_by_merchant_id("12334185")
    assert_equal "12334185", item[0].merchant_id
  end
end
