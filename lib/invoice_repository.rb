require_relative "../lib/invoice"
require_relative '../lib/sales_engine'
require "csv"

class InvoiceRepository
attr_reader :all,
            :parent

  def inspect
    "#{self.class} #{all.size}"
  end

  def initialize(data_path, parent=nil)
    @parent = parent
    csv_loader(data_path)
  end

  def csv_loader(data_path)
    csv = CSV.open data_path, headers:true, header_converters: :symbol
    invoice_parser(csv)
  end

  def invoice_parser(csv)
    @all = csv.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_all_by_date(date_input)
    all.find_all do |instance|
      instance.created_at.to_date == date_input.to_date
    end
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def find_by_id(id)
    all.find do |instance|
      instance.id == id
    end
  end

  def find_all_by_customer_id(customer_id_input)
    all.find_all do |instance|
      instance.customer_id == customer_id_input
    end
  end

  def find_all_by_merchant_id(merchant_id_input)
    all.find_all do |instance|
      instance.merchant_id == merchant_id_input
    end
  end

  def find_all_by_status(status_input)
    all.find_all do |instance|
      instance.status == status_input
    end
  end

  def find_all_items_by_invoice_id(invoice_id)
    parent.find_all_items_by_invoice_id(invoice_id)
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    parent.find_all_transactions_by_invoice_id(invoice_id)
  end

  def find_all_customers_by_invoice_id(invoice_id)
    parent.find_all_customers_by_invoice_id(invoice_id)
  end

  def find_all_invoice_items_by_invoice_id(invoice_id)
    parent.find_all_invoice_items_by_invoice_id(invoice_id)
  end
end
