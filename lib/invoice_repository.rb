require_relative "../lib/invoice"
require_relative '../lib/sales_engine'
require "csv"
# require 'pry'

class InvoiceRepository
attr_reader :all,
            :parent

  def inspect
    "#{self.class} #{@invoices.size}"
  end

  def initialize(data_path, parent=nil)
    @parent = parent
    csv_loader(data_path)
    invoice_parser
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def invoice_parser
    @all = @csv.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def find_by_id(id)
    all.find do |instance|
      instance.id == id.to_i
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
    @parent.find_all_items_by_invoice_id(invoice_id)
  end
end
