require_relative '../test/test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :tr
  def setup
    @tr = TransactionRepository.new
    tr.from_csv("./data/small/transactions.csv")
  end

  def test_transaction_repository_exists
    assert_instance_of TransactionRepository, tr
  end

  def test_all_returns_an_array_of_known_transaction_instances
    assert_instance_of Array, tr.all
    assert_equal 31, tr.all.count
    assert_instance_of Transaction, tr.all[0]
  end

  def test_find_by_id_returns_matching_instance_of_transaction
    assert_instance_of Transaction, tr.find_by_id(6)
    assert_equal 702, tr.find_by_id(15).invoice_id
  end

  def test_find_all_by_invoice_number
    assert_instance_of Array, tr.find_all_by_invoice_id(702)
    assert_equal 2, tr.find_all_by_invoice_id(3477).count
  end

  def test_find_all_by_credit_card_number
    assert_instance_of Array, tr.find_all_by_credit_card_number(4279380734327937)
    assert_equal 1, tr.find_all_by_credit_card_number(4279380734327937).count
  end

  def test_find_all_by_result
    assert_instance_of Array, tr.find_all_by_result("success")
    assert_equal 6, tr.find_all_by_result("failed").count
  end
end
