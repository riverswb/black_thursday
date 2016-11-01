require './test/test_helper'
require './lib/merchant'
class MerchantTest < Minitest::Test

  def test_merchant_class_exists
    m = Merchant.new({:id => 1})
    assert_equal Merchant, m.class
  end

  def test_merchant_has_an_id
    m = Merchant.new({:id => 1})
    assert_equal 1, m.id
  end

  def test_merchant_has_a_name
    m = Merchant.new({:name => "Brett"})
    assert_equal "Brett", m.name
  end

  def test_merchant_has_a_created_at_time
    m = Merchant.new({:created_at => Time.now.strftime("%m/%d/%Y")})
    assert_equal Time.now.strftime("%m/%d/%Y"), m.created_at
  end

  def test_merchant_has_an_updated_time
    m = Merchant.new({:updated_at => Time.now.strftime("%m/%d/%Y")})
    assert_equal Time.now.strftime("%m/%d/%Y"), m.updated_at
  end
end
