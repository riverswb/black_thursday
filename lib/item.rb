require 'bigdecimal'
class Item
  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at
  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @unit_price = args[:unit_price].to_f
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
