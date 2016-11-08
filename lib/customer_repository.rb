require 'csv'
require_relative '../lib/customer'

class CustomerRepository
  attr_reader :all,
              :parent

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def initialize(csv_file = nil, parent = nil)
    @parent = parent
    from_csv(csv_file) if !csv_file.nil?
  end

  def from_csv(csv_file)
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    customer_parser(content)
  end

  def customer_parser(content)
    @all = content.map do |row|
      Customer.new(row, self)
    end
  end

  def find_by_id(id)
    all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |customer|
      customer.id == invoice_id
    end
  end
end
