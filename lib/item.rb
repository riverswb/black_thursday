require 'bigdecimal'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @description = args[:description]
    @unit_price = BigDecimal.new(args[:unit_price].to_i)
    binding.pry
    @created_at = Time.now
    @updated_at = args[:updated_at]
    @merchant_id = args[:merchant_id]
  end

  def unit_price_to_dollars
    binding.pry
    unit_price.to_f
  end
end
