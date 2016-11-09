require "time"

class Invoice

  attr_reader   :id,
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

  def pending?
    also_pending =
    transactions.none? { |transaction| transaction.result == "success" }
    if  also_pending == true
        true
    elsif transactions.length == 0
      false
    else
      false
    end
  end

  def merchant
    parent.find_merchant_by_id(merchant_id)
  end

  def items
    parent.find_all_items_by_invoice_id(self.id)
  end

  def transactions
    parent.find_all_transactions_by_invoice_id(self.id)
  end

  def customer
    parent.find_all_customers_by_invoice_id(self.id)
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result.downcase == "success"
    end
  end

  def invoice_items
    parent.find_all_invoice_items_by_invoice_id(id)
  end

  def total
    invoice_items.map do |item|
      (item.quantity * item.unit_price)
    end.reduce(:+)
  end
end
