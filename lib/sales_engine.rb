require_relative '../lib/item_repository'
require_relative '../lib/file_loader'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoice_items,
              :transactions,
              :customers,
              :invoices
  def initialize(csv_files)
    @items = ItemRepository.new(csv_files[:items], self)
    @merchants = MerchantRepository.new(csv_files[:merchants], self)
    @invoice_items = InvoiceItemRepository.new(csv_files[:invoice_items], self)
    @transactions = TransactionRepository.new(csv_files[:transactions], self)
    @customers = CustomerRepository.new(csv_files[:customers])
    @invoices = InvoiceRepository.new(csv_files[:invoices],self)
  end

  def self.from_csv(csv_files = nil)
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

  def find_all_items_by_invoice_id(invoice_id)
    invoices.find_all_by_invoice_id(invoice_id)
  end

  def find_all_items_by_invoice_id(invoice_id)
    found_items = invoice_items.find_all_by_invoice_id(invoice_id)
    found_items.map do |invoice_item|
      items.find_by_id(invoice_item.item_id)
    end
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    transaction_items = transactions.find_all_by_invoice_id(invoice_id)
    transaction_items.map do |trans_item|
      transactions.find_by_id(trans_item.id)
    end
  end

  def find_all_customers_by_invoice_id(invoice_id)
    found = invoices.find_by_id(invoice_id)
    customers.find_by_id(found.customer_id)
  end

  def find_customers_by_id(id)
    customers.find_by_id(id)
  end

  def find_invoice_by_id(id)
    invoices.find_by_id(id)
  end

  def find_all_customers_by_merchant_id(merchant_id)
    found_invoices = find_all_invoices_by_merchant_id(merchant_id)
    customer_ids = found_invoices.map {|invoice| invoice.customer_id}
    customer_ids.map do |id|
      customers.find_by_id(id)
    end.uniq
  end
end
