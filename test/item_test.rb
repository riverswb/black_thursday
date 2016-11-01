require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test
  # def test_item_exists
  #   i = Item.new({:name => "Pencil"})
  #   assert_equal Item, i.class
  # end
  #
  # def test_item_has_a_name
  #   i = Item.new({:name => "Pencil"})
  #   assert_equal "Pencil", i.name
  # end
  #
  # def test_item_has_a_description
  #   i = Item.new({:description => "You can use it to write things"})
  #     assert_equal "You can use it to write things", i.description
  # end
  #
  # def test_item_has_a_unit_price_formatted_as_a_bigdecimal
  #   i = Item.new({:unit_price => 700})
  #   assert_equal BigDecimal, i.unit_price.class
  # end
  #
  # def test_item_has_a_created_at_date
  #   i = Item.new({:created_at => Time.now.strftime("%m/%d/%Y")})
  #   assert_equal Time.now.strftime("%m/%d/%Y"), i.created_at
  # end
  #
  # def test_item_has_an_updated_at_date
  #   i = Item.new({:updated_at => Time.now.strftime("%m/%d/%Y")})
  #   assert_equal Time.now.strftime("%m/%d/%Y"), i.updated_at
  # end
  #
  # def test_item_has_a_merchant_id
  #   i = Item.new({:merchant_id => 263395237})
  #   assert_equal 263395237, i.merchant_id
  # end

  def test_unit_price_to_dollars_returns_price_as_float
    i = Item.new({:unit_price => "700"})
    assert_equal 700, i.unit_price_to_dollars
  end

end
