require_relative '../test/test_helper'
require_relative "../lib/invoice"
require_relative "../lib/sales_engine"

class InvoiceTest < MiniTest::Test
  attr_reader :invoice,
              :se
  def setup
    @se = SalesEngine.from_csv({
      :items         => "./data/small/items.csv",
      :merchants     => "./data/small/merchants.csv",
      :invoices      => "./data/small/invoices.csv",
      :transactions  => "./data/small/transactions.csv",
      :invoice_items => "./data/small/invoice_items.csv",
      :customers     => "./data/small/customers.csv"})
    @invoice = Invoice.new({
      :id           => "6",
      :customer_id  => "7",
      :merchant_id  => "8",
      :status       => "pending",
      :created_at   => "#{Time.now}",
      :updated_at   => "#{Time.now}"})
  end

  def test_knows_and_stores_id
    assert_equal 6, invoice.id
  end

  def test_knows_and_stores_customer_id
    assert_equal 7, invoice.customer_id
  end

  def test_knows_and_stores_merchant_id
    assert_equal 8, invoice.merchant_id

  end

  def test_status_exists_and_returns_value
    assert_equal :pending, invoice.status
  end

  def test_knows_and_stores_parsed_created_at
    assert_equal true, invoice.created_at.is_a?(Time)
  end

  def test_knows_and_stores_parsed_updated_at
    assert_equal true, invoice.updated_at.is_a?(Time)
  end

  def test_it_finds_by_merchant_id
    assert_equal Merchant, se.invoices.find_merchant_by_id(12334160).class
  end

  def test_it_returns_array_of_items
    assert_equal Item, se.invoices.find_by_id(3).items.last.class
  end

  def test_it_returns_a_customer
    assert_instance_of Customer, se.customers.find_by_id(2)
  end

  def test_false_when_not_paid_in_full
    refute se.invoices.find_by_id(2).is_paid_in_full?
  end

  def test_it_gets_an_array_of_invoice_items
    assert se.invoices.find_by_id(1).invoice_items.is_a?(Array)
    assert_instance_of InvoiceItem, se.invoices.find_by_id(1).invoice_items[0]
  end

  def test_returns_total_amount_of_invoice
    assert_instance_of BigDecimal, se.invoices.find_by_id(2).total
  end

  def test_returns_true_if_invoices_are_pending
    assert se.invoices.find_by_id(1).pending?
  end
end
