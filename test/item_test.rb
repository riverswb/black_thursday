require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def test_item_exists
    i = Item.new({:name => "Pencil"})
    assert_equal Item, i.class
  end

  def test_item_has_a_name
    i = Item.new({:name => "Pencil"})
    assert_equal "Pencil", i.name
  end

  def test_item_has_a_description
    i = Item.new({:description => "You can use it to write things"
      })
      assert_equal "You can use it to write things", i.description
  end

  def test_item_has_a_unit_price
    i = Item.new({:unit_price => BigDecimal.new(10.99,4)})
    assert_equal 10.99, i.unit_price
  end

  def test_item_has_a_created_at_date
    i = Item.new({:created_at => Time.now.strftime("%m/%d/%Y")})
    assert_equal Time.now.strftime("%m/%d/%Y"), i.created_at
  end

  def test_item_has_an_updated_at_date
    i = Item.new({:updated_at => Time.now.strftime("%m/%d/%Y")})
    assert_equal Time.now.strftime("%m/%d/%Y"), i.updated_at
  end

end
