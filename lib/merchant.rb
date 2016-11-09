require_relative '../lib/merchant_repository'

class Merchant
  attr_reader   :name,
                :id,
                :created_at,
                :updated_at,
                :parent
  attr_accessor :items
  def initialize(merchant_data, parent=nil)
    @name       = merchant_data[:name].to_s
    @id         = merchant_data[:id].to_i
    @created_at = merchant_data[:created_at]
    @updated_at = merchant_data[:updated_at]
    @parent = parent
    @items = []
  end

  def revenue
    invoices.reduce(0) do |total, invoice|
      if invoice.total.nil?
        total += 0
      else
        total += invoice.total
      end
    end
  end

  def total
    invoices.reduce(0) do |sum, invoice|
      if invoice.total.class != nil
        sum += invoice.total
      end
    end
  end

  def items
    @items << @parent.find_all_items_by_merchant_id(self.id)
  end

  def invoices
    @parent.find_all_invoices_by_merchant_id(id)
  end

  def customers
    @parent.find_all_customers_by_merchant_id(id)
  end
end
