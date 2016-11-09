require 'csv'
require_relative '../lib/invoice_item'

class InvoiceItemRepository
  attr_reader :all,
              :parent

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(csv_file = nil, parent = nil)
    @parent = parent
    from_csv(csv_file) if !csv_file.nil?
  end

  def from_csv(csv_file)
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    invoice_item_parser(content)
  end

  def invoice_item_parser(content)
    @all = content.map do |row|
      InvoiceItem.new(row)
    end
  end

  def find_by_id(id)
    all.find do |item|
      item.id.to_i == id
    end
  end

  def find_all_by_item_id(item_id)
    all.find_all do |item|
      item.item_id.to_i == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |item|
      item.invoice_id.to_i == invoice_id
    end
  end
end
