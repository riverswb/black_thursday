require_relative '../test/test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :t
  def setup
    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_transaction_exists
    assert_instance_of Transaction, t
  end

  def test_id_returns_the_integer_id
    assert_equal 6, t.id
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 8, t.invoice_id
  end

  def test_credit_card_number_returns_the_credit_card_number
    assert_equal "4242424242424242", t.credit_card_number
  end

  def test_credit_card_expiration_date_returns_cc_expiration
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_result_returns_transaction_result
    assert_equal "success", t.result
  end

  def test_created_at_returns_an_instance_of_time
    assert_instance_of Time, t.created_at
  end

  def test_updated_at_returns_an_instance_of_time
    assert_instance_of Time, t.updated_at
  end

end
