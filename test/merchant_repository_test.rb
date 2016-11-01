require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
  end

  def test_merchant_repository_exists
    merchant_repository = se.merchants
    assert_equal MerchantRepository, merchant_repository.class
  end
end
