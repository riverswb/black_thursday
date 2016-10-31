require 'csv'
class SalesEngine

  def self.from_csv(files)
    if files.keys.include?(:items)
      parse_items(files)
    elsif files.keys.include?(:merchants)
      parse_merchants(files)
    end
  end

  def self.parse_items(files)
    contents = CSV.read (files[:items]), headers: true, header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      merchant_id = row[:merchant_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
    end
  end

  def self.parse_merchants(files)
    contents = CSV.read (files[:merchants]), headers: true, header_converters: :symbol
    contents.each do |row|
      id = [:id]
      name = [:name]
      created_at = [:created_at]
      updated_at = [:updated_at]
    end
  end
end
