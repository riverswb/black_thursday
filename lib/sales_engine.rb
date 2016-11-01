require 'csv'
class SalesEngine

  def self.from_csv(files)
    if files.keys.include?(:items)
      items(files)
    elsif files.keys.include?(:merchants)
      merchants(files)
    end
  end

  def self.items(files)
    item_repository = ItemRepository.new
    item_repository = CSV.read (files[:items]), headers: true, header_converters: :symbol
    item_repository.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      merchant_id = row[:merchant_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
    end
  end

  def self.merchants(files)
    merchants_repository = MerchantsRepository.new
    merchants_repository = CSV.read (files[:merchants]), headers: true, header_converters: :symbol
    merchants_repository.each do |row|
      id = [:id]
      name = [:name]
      created_at = [:created_at]
      updated_at = [:updated_at]
    end
  end
end
