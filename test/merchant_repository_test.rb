require_relative '../test/test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchants,
              :se

  def setup
    @se = SalesEngine.from_csv({
     :items         => "./data/small/items.csv",
     :merchants     => "./data/small/merchants.csv",
     :invoices      => "./data/small/invoices.csv",
     :transactions  => "./data/small/transactions.csv",
     :invoice_items => "./data/small/invoice_items.csv",
     :customers     => "./data/small/customers.csv"})
    @merchants = MerchantRepository.new("./data/small/merchants.csv")
  end

  def test_merchant_repository_exists
    merchant_repository = merchants
    assert_equal MerchantRepository, merchant_repository.class
  end

  def test_makes_array_of_all_merchant_information
    merchant_repository = merchants
    assert_equal 30, merchant_repository.all.count
  end

  def test_can_find_merchant_by_id
    merchant_repository = merchants
    merchant =  merchant_repository.find_by_id(12334105)
    assert_equal "Shopin1901", merchant.name
  end

  def test_finds_all_merchants_by_name
    merchant_repository = merchants
    merchant = merchant_repository.find_by_name("Shopin1901")
    assert_equal "Shopin1901", merchant.name
  end

  def test_finds_all_merchants_case_insensitive_like_brett
    merchant_repository = merchants
    merchant = merchant_repository.find_by_name("ShOpIn1901")
    assert_equal "Shopin1901", merchant.name
  end

  def test_merchant_maker_does_its_job
    merchant_repository = merchants
    assert_equal 12334112, merchant_repository.all[1].id
    assert_equal "Shopin1901", merchant_repository.all[0].name
  end

  def test_all_returns_all_the_merchant_instances
    merchant_repository = merchants
    assert_equal "Shopin1901", merchant_repository.all.first.name
    assert_equal "Snewzy", merchant_repository.all.last.name
  end

  def test_find_by_id_invalid_returns_nil
    merchant_repository = merchants
    assert_equal nil, merchant_repository.find_by_id(0)
  end

  def test_it_returns_with_invalid_name
    merchant_repository = merchants
    assert_equal nil, merchant_repository.find_by_name("idontexist")
  end

  def test_it_finds_all_by_name
    merchant_repository = merchants
    assert_equal 6, merchant_repository.find_all_by_name("AR").length
    assert_equal "LolaMarleys", merchant_repository.find_all_by_name("AR")[1].name
    assert_equal 1, merchant_repository.find_all_by_name("candis").length
    assert_equal "Candisart", merchant_repository.find_all_by_name("candis")[0].name
    assert_equal 6, merchant_repository.find_all_by_name("AR").length
  end

  def test_returns_empty_list_when_no_merchants_match_string
    merchant_repository = merchants
    assert_equal [], merchant_repository.find_all_by_name("idontexist")
  end
end
