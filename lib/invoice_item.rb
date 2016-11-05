require 'bigdecimal'

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
    @invoice_id = args[:invoice_id]
    @quantity = args[:quantity]
    @unit_price = args[:unit_price]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
