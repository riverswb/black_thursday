require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../test/test_helper'
require 'csv'

class SalesEngineTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
          :items         => "./data/small/items.csv",
          :merchants     => "./data/small/merchants.csv",
          :invoices      => "./data/small/invoices.csv",
          :invoice_items => "./data/small/invoice_items.csv",
          :transactions  => "./data/small/transactions.csv",
          :customers     => "./data/small/customers.csv"
        })
    end

  def test_sales_engine_reads_from_item_csv_file
    assert_equal 12334141, se.items.all[0].merchant_id
  end

  def test_reads_multiple_items_and_rows_from_csv_file
    assert_equal "Glitter scrabble frames", se.items.all[1].name
  end

  def test_reads_from_merchant_csv_files
    assert_equal 12334105, se.merchants.all[0].id
  end

  def test_reads_multiple_merchants_and_rows_from_csv_file
    assert_equal "Shopin1901", se.merchants.all[0].name
    assert_equal "Candisart", se.merchants.all[1].name
  end

  def test_there_is_a_relationship_layer_for_merchants
    merchant = se.merchants.find_by_id(12334141)
    merchant.items
    assert_instance_of Array, merchant.items
  end

  def test_we_can_find_item_connections_from_an_invoice
    invoice = se.invoices.find_by_id(1)
    assert_instance_of Array, invoice.items
    assert_instance_of Item, invoice.items[0]
  end

  def test_we_can_find_transaction_connections_from_an_invoice
    invoice = se.invoices.find_by_id(46)
    assert_instance_of Array, invoice.transactions
    assert_instance_of Transaction, invoice.transactions[0]
  end

  def test_we_can_find_customers_by_id
    customer = se.customers.find_by_id(30)
    assert_instance_of Customer, customer
    assert_equal "Elva", customer.first_name
  end

  def test_we_can_find_customer_connections_from_an_invoice
    invoice = se.invoices.find_by_id(20)
    assert_instance_of Customer, invoice.customer
    assert_equal "Sylvester", invoice.customer.first_name
  end

  def test_can_find_invoice_by_transaction_number
    transaction = se.transactions.find_by_id(20)
    assert_instance_of Invoice, transaction.invoice
    assert_equal 537, transaction.invoice.customer_id
  end

  def test_merchant_can_return_related_customers
    merchant = se.merchants.find_by_id(12334115)
    assert_instance_of Array, merchant.customers
    assert_equal 2, merchant.customers.count
    assert_equal "Thiel", merchant.customers[0].last_name
  end

  def test_business_intelligence_we_know_if_invoice_is_paid_in_full
    invoice_1 = se.invoices.find_by_id(1)
    invoice_2 = se.invoices.find_by_id(46)
    assert_equal false, invoice_1.is_paid_in_full?
    assert_equal true, invoice_2.is_paid_in_full?
  end

  def test_can_get_the_total_money_amount_of_an_invoice
    invoice = se.invoices.find_by_id(1)
    assert_equal 21067.77, invoice.total
  end
end
