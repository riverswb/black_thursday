require_relative "../lib/merchant"
require "csv"

class MerchantRepository
attr_reader :all,
            :name,
            :id

  def initialize(csv_file, sales_engine=nil)
    @all = []
    csv_loader(csv_file)
    merchant_parser
  end

  def csv_loader(csv_file)
    @csv = CSV.open csv_file, headers:true, header_converters: :symbol
  end

  def merchant_parser
    @all = @csv.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_id(id_input)
    @all.find do |instance|
      instance.id == id_input.to_i
    end
  end

  def find_by_name(name_input)
    @all.find do |instance|
      instance.name.downcase == name_input.to_s.downcase
    end
  end

  def find_all_by_name(name_fragment)
    @all.find_all do |instance|
      instance.name.downcase.include?(name_fragment.to_s.downcase)
    end
  end
end
