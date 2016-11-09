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
    @created_at = Time.parse(merchant_data[:created_at])
    @updated_at = Time.parse(merchant_data[:updated_at])
    @parent = parent
    @items = []
  end

  def single_sellers?
    items.length == 1
  end

  def revenue
    invoices.map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  def items
    @items << parent.find_all_items_by_merchant_id(self.id)
  end

  def invoices
    parent.find_all_invoices_by_merchant_id(id)
  end

  def customers
    parent.find_all_customers_by_merchant_id(id)
  end
end
