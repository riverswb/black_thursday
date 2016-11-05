require 'csv'
require_relative '../lib/transaction'

class TransactionRepository
  attr_reader :all
  def from_csv(csv_file)
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    transaction_parser(content)
  end

  def transaction_parser(content)
    @all = content.map do |row|
      Transaction.new(row)
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
end
