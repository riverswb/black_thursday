require './lib/item'

class ItemRepository
  attr_reader :items
  def initialize(csv_file)
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    @items = content.map do |row|
      Item.new(row)
    end
  end

  def all
    #this just returns everything right now
    binding.pry
    items
  end

  def find_by_id(id_number)
    #returns either nil or an instance of Item with a matching ID
    items.find do |item|
      item.id == id_number
    end
  end

  def find_by_name(input)
    items.find do |item|
      item.name == input
    end
  end

  def find_by_description(input)
    items.find_all do |item|
      item.description.include?(input)
    end
  end

  def find_all_by_price(input)
    items.find_all do |item|
      item.unit_price
  end
end
