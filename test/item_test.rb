require_relative '../test/test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_reader :i
  def setup
    @i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2007-06-04 21:35:10 UTC",
      :merchant_id => 263395237
    })
  end

  def test_item_exists
    assert_equal Item, i.class
  end

  def test_item_has_a_name
    assert_equal "Pencil", i.name
  end

  def test_item_has_a_description
      assert_equal "You can use it to write things", i.description
  end

  def test_item_has_a_unit_price_formatted_as_a_bigdecimal
    assert_equal BigDecimal, i.unit_price.class
  end

  def test_item_has_a_created_at_date
    assert_equal Time, i.created_at.class
  end

  def test_item_has_an_updated_at_date
    assert_equal Time, i.updated_at.class
  end

  def test_item_has_a_merchant_id
    assert_equal 263395237, i.merchant_id
  end

  # def test_unit_price_to_dollars_returns_price_as_float
  #   assert_equal 10.99, i.unit_price_to_dollars
  # end

end
