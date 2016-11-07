require "time"

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent
  # attr_accessor :item
  def initialize(invoice_data, parent=nil)
    @id          = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status      = invoice_data[:status].to_sym
    @created_at  = Time.parse(invoice_data[:created_at])
    @updated_at  = Time.parse(invoice_data[:updated_at])
    @parent      = parent
  end

  def merchant
    @parent.find_merchant_by_id(merchant_id)
  end

  def items
    @parent.find_all_items_by_invoice_id(self.id)
  end
end
