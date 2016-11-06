require "time"

class Merchant
  attr_reader   :name,
                :id,
                :created_at,
                :updated_at,
                :parent,
                :items,
                :invoices

  def initialize(merchant_data, parent=nil)
    @name       = merchant_data[:name].to_s
    @id         = merchant_data[:id].to_i
    @created_at = merchant_data[:created_at]
    @updated_at = merchant_data[:updated_at]
    @parent = parent
    @items = []
    @invoices = []
  end

  def items
    @items << @parent.find_all_items_by_merchant_id(self.id)
  end




end
