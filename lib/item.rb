require 'bigdecimal'
class Item
  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @unit_price = args[:unit_price]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
    @merchant_id = args[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
