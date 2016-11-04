require_relative '../test/test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  # def test_interction_of_se_with_invoice
  #   se = SalesEngine.from_csv({
  #     :items => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     :invoices => "./data/invoices.csv"})
  #   merchant = merchant = se.merchants.find_by_id(10)
  #   assert_equal 3, merchant.invoices.count
  # end

  def test_creates_SalesEngine_object
    se = SalesEngine.from_csv({
      :items =>"./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"})
    assert_equal SalesEngine, se.class
  end

  def test_sales_engine_reads_from_item_csv_file
    se = SalesEngine.from_csv({
      :items =>"./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"})
    assert_equal 12334141, se.items.all[0].merchant_id
  end

  # def test_finds_merchant_by_id
  #   se = SalesEngine.from_csv({
  #     :items =>"./data/small/items.csv",
  #     :merchants => "./data/small/merchants.csv"})
  #   assert_equal "Shopin1901", se.merchants.find_by_id(12334105)
  # end

  def test_reads_multiple_items_and_rows_from_csv_file
    se = SalesEngine.from_csv({
      :items =>"./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"})
    assert_equal "Glitter scrabble frames", se.items.all[1].name
  end

  def test_reads_from_merchant_csv_files
    se = SalesEngine.from_csv({
      :items =>"./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"})
    assert_equal 12334105, se.merchants.all[0].id
  end

  def test_reads_multiple_merchants_and_rows_from_csv_file
    se = SalesEngine.from_csv({
      :items =>"./data/small/items.csv",
      :merchants => "./data/small/merchants.csv"})
    assert_equal "Shopin1901", se.merchants.all[0].name
    assert_equal "Candisart", se.merchants.all[1].name
  end
end
