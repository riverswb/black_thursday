require_relative "../lib/merchant"
require_relative '../lib/sales_engine'
require "csv"

class MerchantRepository

  def inspect
    "#{self.class} #{@merchants.size}"
  end

  def initialize(csv_file, parent = nil)
    @merchants = []
    @parent = parent
    csv_loader(csv_file)
    merchant_parser
  end

  def all
    @merchants
  end

  def csv_loader(csv_file)
    @csv = CSV.open csv_file, headers:true, header_converters: :symbol
  end

  def merchant_parser
    @merchants = @csv.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_id(id_input)
    @merchants.find do |instance|
      instance.id == id_input.to_i
    end
  end

  def find_by_name(name_input)
    @merchants.find do |instance|
      instance.name.downcase == name_input.to_s.downcase
    end
  end

  def find_all_by_name(name_fragment)
    @merchants.find_all do |instance|
      instance.name.downcase.include?(name_fragment.to_s.downcase)
    end
  end

  def find_all_items_by_merchant_id(merchant_id)
    @parent.find_all_items_by_merchant_id(merchant_id)
  end

  def invoices
    @se.invoices.find_all_by_merchant_id(merchant_id)
  end
end
