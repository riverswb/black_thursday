require_relative "../lib/merchant"
require "csv"
require 'pry'


class MerchantRepository
attr_reader :all

  def initialize(data_path, sales_engine=nil)
    @all = []
    csv_loader(data_path)
    merchant_maker
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def merchant_maker
    @all = @csv.map do |row|
      Merchant.new(row, self)
    end
  end
end
