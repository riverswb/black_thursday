require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(args)
    @id = args[:id].to_i
    @item_id = args[:item_id].to_i
    @invoice_id = args[:invoice_id].to_i
    @quantity = args[:quantity].to_i
    @unit_price = (args[:unit_price].to_f / 100 ).to_d
    @created_at = Time.parse(args[:created_at])
    @updated_at = Time.parse(args[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_f * 100
  end
end
