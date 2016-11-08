require_relative '../test/test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :se,
              :merchants

  def setup
    @se = SalesEngine.from_csv({
           :items         => "../data/small/items.csv",
           :merchants     => "../data/small/merchants.csv"})
    @merchants = MerchantRepository.new("../data/merchants.csv")
  end

  def test_merchant_repository_exists
    merchant_repository = se.merchants
    assert_equal MerchantRepository, merchant_repository.class
  end

  def test_makes_array_of_all_merchant_information
    merchant_repository = se.merchants
    assert_equal 30, merchant_repository.all.count
  end

  def test_can_find_merchant_by_id
    merchant_repository = se.merchants
    merchant =  merchant_repository.find_by_id(12334105)
    assert_equal "Shopin1901", merchant.name
  end

  def test_finds_all_merchants_by_name
    merchant_repository = se.merchants
    merchant = merchant_repository.find_by_name("Shopin1901")
    assert_equal "Shopin1901", merchant.name
  end

  def test_finds_all_merchants_case_insensitive_like_brett
    merchant_repository = se.merchants
    merchant = merchant_repository.find_by_name("ShOpIn1901")
    assert_equal "Shopin1901", merchant.name
  end

end
