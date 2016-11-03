require './test/test_helper'
require_relative "../lib/invoice"
require_relative "../lib/sales_engine"
require 'pry'


class InvoiceTest < MiniTest::Test
  def setup
    @invoice = Invoice.new({ :id           => "6",
                             :customer_id  => "7",
                             :merchant_id  => "8",
                             :status       => "pending",
                             :created_at   => "#{Time.now}",
                             :updated_at   => "#{Time.now}"})
  end

  def test_it_holds_an_id
    assert_equal 6, @invoice.id
  end

  def test_it_holds_customer_id
    assert_equal 7, @invoice.customer_id
  end

  def test_it_holds_merchant_id
    assert_equal 8, @invoice.merchant_id

  end

  def test_it_has_a_status
    assert_equal :pending, @invoice.status
  end

  def test_it_holds_a_parsed_created_at
    assert_equal true, @invoice.created_at.is_a?(Time)
  end

  def test_it_holds_a_parsed_updated_at
    assert_equal true, @invoice.updated_at.is_a?(Time)
  end
end
