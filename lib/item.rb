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
    @id = args[:id].to_i
    @name = args[:name]
    @description = args[:description]
    @unit_price = BigDecimal.new(args.fetch(:unit_price, 0))
    @created_at = Time.now.strftime("%m/%d/%Y")
    @updated_at = args[:updated_at]
    @merchant_id = args[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
