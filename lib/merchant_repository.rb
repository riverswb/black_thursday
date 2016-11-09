require_relative "../lib/merchant"
require_relative '../lib/sales_engine'
require "csv"

class MerchantRepository
  attr_reader :invoices,
              :merchants,
              :parent

  def inspect
    "#{self.class} #{all.size}"
  end

  def initialize(csv_file, parent = nil)
    @merchants = []
    @parent = parent
    csv_loader(csv_file)
  end

  def all
    merchants
  end

  def csv_loader(csv_file)
    csv = CSV.open csv_file, headers:true, header_converters: :symbol
    merchant_parser(csv)
  end

  def merchant_parser(csv)
    csv.each do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def find_by_id(id_input)
    merchants.find do |instance|
      instance.id == id_input
    end
  end

  def find_by_name(name_input)
    merchants.find do |instance|
      instance.name.downcase == name_input.to_s.downcase
    end
  end

  def find_all_by_name(name_fragment)
    merchants.find_all do |instance|
      instance.name.downcase.include?(name_fragment.to_s.downcase)
    end
  end

  def find_all_items_by_merchant_id(merchant_id)
    parent.find_all_items_by_merchant_id(merchant_id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    parent.find_all_invoices_by_merchant_id(merchant_id)
  end

  def find_all_customers_by_merchant_id(id)
    parent.find_all_customers_by_merchant_id(id)
  end
end
