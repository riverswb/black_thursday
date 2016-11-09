require 'csv'
require_relative '../lib/transaction'
require 'pry'

class TransactionRepository
  attr_reader :all,
              :parent

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def initialize(csv_file = nil, parent = nil)
    from_csv(csv_file) if !csv_file.nil?
    @parent = parent
  end

  def from_csv(csv_file)
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    transaction_parser(content)
  end

  def transaction_parser(content)
    @all = content.map do |row|
      Transaction.new(row, self)
    end
  end

  def find_by_id(id)
    all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(number)
    all.find_all do |transaction|
      transaction.invoice_id == number
    end
  end

  def find_all_by_credit_card_number(number)
    all.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_invoice_by_id(id)
    parent.find_invoice_by_id(id)
  end
end
