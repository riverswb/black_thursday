require './test/test_helper'
require_relative "../lib/invoice"
require_relative "../lib/sales_engine"

class InvoiceTest < MiniTest::Test
  def setup
    @invoice = Invoice.new({ :id           => "6",
                             :customer_id  => "7",
                             :merchant_id  => "8",
                             :status       => "pending",
                             :created_at   => "#{Time.now}",
                             :updated_at   => "#{Time.now}"})
  end

  def test_creates_an_invoice_object
    assert_equal Invoice, @invoice.class
  end

  def test_creates_invoice_and_stores_as_customer_with_assigned_id_number
    assert_equal 6, @invoice.id
    assert_equal 7, @invoice.customer_id
    assert_equal 8, @invoice.merchant_id
  end

  def test_knows_and_returns_status
    assert_equal :pending, @invoice.status
  end

  def test_holds_a_parsed_created_at_object
    assert @invoice.created_at.is_a?(Time)
  end

  def test_can_parse_time_for_invoice_and_store_for_use
    assert @invoice.updated_at.is_a?(Time)
  end
end
