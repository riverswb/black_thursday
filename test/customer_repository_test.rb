require_relative '../test/test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :cr
  def setup
    @cr = CustomerRepository.new
    cr.from_csv("./data/small/customers.csv")
  end

  def test_customer_repository_exists
    assert_instance_of CustomerRepository, cr
  end

  def test_all_returns_array_of_all_known_customers
    assert_instance_of Array, cr.all
    assert_instance_of Customer, cr.all[0]
    assert_equal 30, cr.all.count
  end

  def test_find_by_id_returns_customer_matching_id
    assert_instance_of Customer, cr.find_by_id(11)
    assert_equal "Logan", cr.find_by_id(11).first_name
  end

  def test_find_all_by_first_name
    assert_instance_of Array, cr.find_all_by_first_name("Logan")
    assert_equal 2, cr.find_all_by_first_name("jo").count
  end

  def test_find_all_by_last_name
    assert_instance_of Array, cr.find_all_by_last_name("Em")
    assert_equal 10, cr.find_all_by_last_name("er").count
  end

end
