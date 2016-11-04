require_relative '../test/test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  attr_reader :ii
  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_invoice_item_exists
    assert_equal InvoiceItem, ii.class
  end

  def test_id_returns_the_integer_id
    assert_equal 6, ii.id
  end

  def test_item_id_returns_the_integer_id
    assert_equal 7, ii.item_id
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 8, ii.invoice_id
  end

  def test_quantity_returns_the_quantity
    assert_equal 1, ii.quantity
  end

  def test_unit_price_returns_the_unit_price
    assert_equal 10.99, ii.unit_price
  end

  def test_created_at_returns_a_time_instanse
    assert_instance_of Time, ii.created_at
  end

  def test_updated_at_returns_a_time_instance
    assert_instance_of Time, ii.updated_at
  end

  def test_unit_price_to_dollars_returns_price_as_a_float
    assert_equal 10.99, ii.unit_price_to_dollars
    assert_instance_of Float, ii.unit_price_to_dollars
  end
end
