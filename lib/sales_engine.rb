require 'csv'
class SalesEngine
  attr_reader :items,
              :merchants
  def initialize(files)
    @items = files[:items]
    @merchants = files[:merchants]
  end

  def self.from_csv(files)
    contents = CSV.open (files[:items]), headers: true, header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:unit_price]
      merchant_id = row[:merchant_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
    end
  end

end
