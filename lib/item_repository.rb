require './lib/item'

class ItemRepository
  attr_reader :items
  def initialize(csv_file)
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    @items = content.map do |row|
      Item.new(row)
    end
  end
end
