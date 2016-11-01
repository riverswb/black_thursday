require './test/test_helper'
require './lib/merchant'


class MerchantTest < Minitest::Test
  def test_merchant_exists_and_has_a_name
    merchant = Merchant.new({:name => "Shopin1901"})
    assert_equal Merchant, merchant.class
    assert_equal "Shopin1901", merchant.name
  end

  def test_merchant_has_an_id_number
    merchant = Merchant.new({:id => "12334105"})
    assert_equal 12334105, merchant.id
  end

  def test_knows_when_merchant_was_created
    merchant = Merchant.new({:created_at => "2010-12-10"})
    assert_equal "2010-12-10", merchant.created_at
  end

  def test_knows_when_merchant_was_updated
    merchant = Merchant.new({:updated_at => "2011-12-04"})
    assert_equal "2011-12-04", merchant.updated_at
  end


end
