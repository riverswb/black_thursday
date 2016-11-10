require 'bigdecimal'
require_relative '../test/test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'


class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository,
              :se
  def setup
    @se = SalesEngine.from_csv({
     :items         => "./data/small/items.csv",
     :merchants     => "./data/small/merchants.csv",
     :invoices      => "./data/small/invoices.csv",
     :transactions  => "./data/small/transactions.csv",
     :invoice_items => "./data/small/invoice_items.csv",
     :customers     => "./data/small/customers.csv"})
    @item_repository = ItemRepository.new("./data/small/items.csv")
  end

  def test_item_repository_exists
    ir = item_repository
    assert_equal ItemRepository, ir.class
  end

  def test_has_method_all
    ir = item_repository
    assert_equal 42, ir.all.count
  end

  def test_has_method_all_returns_array
    ir = item_repository
    assert_equal Array, ir.all.class
  end

  def test_has_method_find_by_id
    ir = item_repository
    item = ir.find_by_id(263395237)
    assert_equal 263395237, item.id
  end

  def test_find_by_id_returns_instance_of_item
    ir = item_repository
    item = ir.find_by_id(263395237)
    assert_instance_of Item, item
  end

  def test_find_by_id_returns_nil_if_not_present
    ir = item_repository
    item = ir.find_by_id(2633957)
    assert_nil item
  end

  def test_has_method_find_by_name
    ir = item_repository
    item = ir.find_by_name("Glitter scrabble frames")
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_find_by_name_is_case_insensitive
    ir = item_repository
    item = ir.find_by_name("glitter Scrabble Frames")
    assert_equal "Glitter scrabble frames", item.name
  end

  def test_find_by_name_returns_instance_of_item
    ir = item_repository
    item = ir.find_by_name("Glitter scrabble frames")
    assert_instance_of Item, item
  end

  def test_find_by_name_returns_nil_if_not_found
    ir = item_repository
    item = ir.find_by_name("Glitter frames")
    assert_nil item
  end

  def test_has_method_find_all_with_description
    ir = item_repository
    item = ir.find_all_with_description("Glitter")
    assert_equal "Glitter scrabble frames", item[0].name
  end

  def test_find_all_with_description_returns_empty_array_if_not_found
    ir = item_repository
    item = ir.find_all_with_description("Glittersdfsdf")
    assert_equal [], item
  end

  def test_has_method_find_all_by_price
    ir = item_repository
    item = ir.find_all_by_price(BigDecimal.new(12))
    assert_equal 2, item.length
  end

  def test_find_all_by_price_in_range
    ir = item_repository
    item = ir.find_all_by_price_in_range(10.00..12.00)
    assert_equal 2, item.length
  end

  def test_has_method_find_all_by_merchant_id
    ir = item_repository
    item = ir.find_all_by_merchant_id(12334185)
    assert_equal 12334185, item[0].merchant_id
  end

  def test_it_finds_by_id
    assert_instance_of Item, item_repository.find_by_id(263395721)
    assert_equal "Disney scrabble frames", item_repository.find_by_id(263395721).name
  end

  def test_it_finds_by_name_invalid
    assert_equal nil, item_repository.find_by_name("not_a_valid_id")
  end

  def test_it_finds_by_name
    assert_instance_of Item, item_repository.find_by_name("Disney scrabble frames")
    assert_equal 263395721, item_repository.find_by_name("Disney scrabble frames").id
  end

  def test_it_finds_all_with_description
    assert_equal [], item_repository.find_all_with_description("Mike Dao is HILARIOUS")
    assert_instance_of Item, item_repository.find_all_with_description("Disney glitter frames").first
    assert_equal 263395721, item_repository.find_all_with_description("Disney glitter frames").first.id
    assert_equal 2, item_repository.find_all_with_description("frames").length
  end

  def test_it_finds_by_price
    assert_equal [], item_repository.find_all_by_price(4895743895)
    assert_instance_of Item, item_repository.find_all_by_price(13.50).first
    assert_equal "Disney scrabble frames", item_repository.find_all_by_price(13.50).first.name
    assert_equal 1, item_repository.find_all_by_price(13.50).length
  end

  def test_it_finds_all_by_merchant_id_is_invalid
    assert_equal [], item_repository.find_all_by_merchant_id(38483)
  end

  def test_it_finds_all_by_merchant_id
    assert_instance_of Item, item_repository.find_all_by_merchant_id(12334185).first
    assert_equal 3, item_repository.find_all_by_merchant_id(12334185).length
    assert_equal "Glitter scrabble frames", item_repository.find_all_by_merchant_id(12334185).first.name
  end

  def test_it_can_tell_you_which_merchant_sells_it
    assert_instance_of Merchant, @se.items.find_by_id(263395237).merchant
  end

  def test_item_count
    assert_equal 42, se.all_items.count
  end


end
