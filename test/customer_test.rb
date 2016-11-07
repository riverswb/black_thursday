require_relative '../test/test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :c
  def setup
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    })
  end

  def test_customer_exists
    assert_instance_of Customer, c
  end

  def test_id_returns_the_integer_id
    assert_equal 6, c.id
  end

  def test_first_name_returns_the_first_name
    assert_equal "Joan", c.first_name
  end

  def test_last_name_returns_the_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_created_at_returns_an_instance_of_time
    assert_instance_of Time, c.created_at
  end

  def test_updated_at_returns_an_instance_of_time
    assert_instance_of Time, c.updated_at
  end
end
