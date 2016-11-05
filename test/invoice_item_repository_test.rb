require_relative '../test/test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :ir
  def setup
    @ir = InvoiceItemRepository.new
    ir.from_csv("./data/small/invoice_item.csv")
  end

  def test_invoice_item_repository_exists
    assert_instance_of InvoiceItemRepository, ir
  end

  def test_all_returns_an_array_of_all_known_invoiceitem_instances
    assert_equal Array, ir.all.class
    assert_equal InvoiceItem, ir.all[0].class
    assert_equal 30, ir.all.count
  end

  def test_find_by_id_returns_nil_or_instance_of_invoice_item_matching_id
    assert_equal 263519844, ir.find_by_id(1).item_id
  end

  def test_find_all_by_item_id_returns_array_of_matches
    assert_equal Array, ir.find_all_by_item_id(263454779).class
    assert_equal 2, ir.find_all_by_item_id(263529264).count
  end

  def test_find_all_by_invoice_id_returns_array_of_matches
    assert_equal Array, ir.find_all_by_invoice_id(1).class
    assert_equal 8, ir.find_all_by_invoice_id(1).count
  end
end
