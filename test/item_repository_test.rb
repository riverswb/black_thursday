require 'bigdecimal'
require_relative '../test/test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository
  def setup
    @item_repository = ItemRepository.new("./data/small/items.csv")
  end

  def test_item_repository_exists
    ir = item_repository
    assert_equal ItemRepository, ir.class
  end

  def test_item_repository_has_method_all
    ir = item_repository
    assert_equal 42, ir.all.count
  end

  def test_item_repository_has_method_all_returns_array
    ir = item_repository
    assert_equal Array, ir.all.class
  end

  def test_item_repository_has_method_find_by_id
    ir = item_repository
    item = ir.find_by_id(263395237)
    assert_equal 263395237, item.id
  end

  def test_item_repository_find_by_id_returns_instance_of_item
    ir = item_repository
    item = ir.find_by_id(263395237)
    assert_instance_of Item, item
  end

  def test_item_repository_find_by_id_returns_nil_if_not_present
    ir = item_repository
    item = ir.find_by_id(2633957)
    assert_nil item
  end

  def test_item_repository_has_method_find_by_name
    ir = item_repository
    item = ir.find_by_name("Glitter scrabble frames")
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_item_repository_has_method_find_by_name_is_case_insensitive
    ir = item_repository
    item = ir.find_by_name("glitter Scrabble Frames")
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_item_repository_find_by_name_returns_instance_of_item
    ir = item_repository
    item = ir.find_by_name("Glitter scrabble frames")
    assert_instance_of Item, item
  end

  def test_item_repository_find_by_name_returns_nil_if_not_found
    ir = item_repository
    item = ir.find_by_name("Glitter frames")
    assert_nil item
  end

  def test_item_repo_has_method_find_all_with_description
    ir = item_repository
    item = ir.find_all_with_description("Glitter")
    assert_equal "Glitter scrabble frames", item[0].name
  end

  def test_item_repo_find_all_with_description_returns_empty_array_if_not_found
    ir = item_repository
    item = ir.find_all_with_description("Glittersdfsdf")
    assert_equal [], item
  end

  def test_item_repo_has_method_find_all_by_price
    ir = item_repository
    item = ir.find_all_by_price(BigDecimal.new(12))
    assert_equal 2, item.length
  end

  def test_find_all_by_price_in_range
    ir = item_repository
    item = ir.find_all_by_price_in_range(10.00..12.00)
    assert_equal 2, item.length
  end

  def test_item_repo_has_method_find_all_by_merchant_id
    ir = item_repository
    item = ir.find_all_by_merchant_id(12334185)
    assert_equal 12334185, item[0].merchant_id
  end
end
