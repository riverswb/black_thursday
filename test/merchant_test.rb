require_relative '../test/test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :merchant

  def setup
    @merchant = Merchant.new({
      :name => "Shopin1901",
      :id   => "12334105",
      :created_at => "2010-12-10",
      :updated_at => "2011-12-04"})
  end

  def test_merchant_exists_and_has_a_name
    assert_equal Merchant, merchant.class
    assert_equal "Shopin1901", merchant.name
  end

  def test_merchant_has_an_id_number
    assert_equal 12334105, merchant.id
  end

  def test_knows_when_merchant_was_created
    assert_instance_of Time, merchant.created_at
  end

  def test_knows_when_merchant_was_updated
    assert_instance_of Time, merchant.updated_at
  end
end
