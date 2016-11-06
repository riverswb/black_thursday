require 'bigdecimal'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent
              
  def initialize(args, parent = nil)
    @id = args[:id].to_i
    @name = args[:name]
    @description = args[:description]
    @unit_price = BigDecimal.new(args.fetch(:unit_price, 0)) / 100
    @created_at = Time.parse(args[:created_at])
    @updated_at = Time.parse(args[:updated_at])
    @merchant_id = args[:merchant_id].to_i
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    @parent.find_merchant_by_id(self.merchant_id)
  end
end
