require 'bigdecimal'

class InvoiceItem

  def initialize(args)
    @id = args[:id]
    @item_id = args[:item_id]
    @invoice_id = args[:invoice_id]
    @quantity = args[:quantity]
    @unit_price = args[:unit_price]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
