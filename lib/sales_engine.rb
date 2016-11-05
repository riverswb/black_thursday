require 'csv'
require_relative '../lib/item_repository'
require_relative '../lib/file_loader'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoice_items,
              :transactions
  def initialize(csv_files)
    @items = ItemRepository.new(csv_files[:items], self)
    @merchants = MerchantRepository.new(csv_files[:merchants], self)
    @invoice_items = InvoiceItemRepository.new(csv_files[:invoice_items])
    @transactions = TransactionRepository.new(csv_files[:transactions])
  end

  def self.from_csv(csv_files = nil)
    self.new(csv_files)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_item_by_id(item_id)
    items.find_by_id(item_id)
  end

  def find_all_items_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def invoice_items
    @invoice_items
  end

  # def transactions
  #   @transactions
  # end
end
