require 'csv'
require_relative '../lib/item_repository'
require_relative '../lib/file_loader'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices
  def initialize(csv_files)
    @items = ItemRepository.new(csv_files[:items], self)
    @merchants = MerchantRepository.new(csv_files[:merchants], self)
    @invoices = InvoiceRepository.new(csv_files[:invoices], self)
  end

  def self.from_csv(csv_files)
    self.new(csv_files)
  end

  def all_invoices
    invoices.all
  end

  def find_invoices_by_merchant_id(merchant_id_input)
    invoices.find_all_by_merchant_id(merchant_id_input)
  end

  def merchant_count
    merchants.all.count
  end

  def all_merchants
    merchants.all
  end

  def invoice_count
    invoices.all.count
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_item_by_id(item_id)
    items.find_by_id(item_id)
  end

  def find_all_items_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end
end
