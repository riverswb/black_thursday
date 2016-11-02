require_relative '../lib/item'

class ItemRepository
  attr_reader :all_items
  def initialize(csv_file)
    @all_items = []
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    item_parser(content)
  end

  def item_parser(content)
    content.map do |row|
      create_item_object(row)
    end
  end

  def create_item_object(data)
    @all_items << Item.new({
    id: data[0],
    name: data[1],
    description: data[2],
    unit_price: data[3],
    created_at: data[6],
    updated_at: data [5],
    merchant_id: data[4]
    })
  end

  def all
    @all_items
  end

  def find_by_id(id_number)
    all_items.find do |item|
      item.id.to_i == id_number
    end
  end

  def find_by_name(input)
    all_items.find do |item|
      item.name.downcase == input.downcase
    end
  end

  def find_by_description(input)
    all_items.find_all do |item|
      item.description.downcase.include?(input.downcase)
    end
  end

  def find_all_by_price(input)
    all_items.find_all do |item|
      item.unit_price
    end
  end

  def find_all_by_price_in_range(low, high)
    all_items.find_all do |item|
      item.unit_price.between?(low.to_i, high.to_i)
    end
  end

  def find_all_by_merchant_id(input)
    all_items.find_all do |item|
      item.merchant_id.to_i == input
    end
  end
end
