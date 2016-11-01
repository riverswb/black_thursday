require './lib/item'

class ItemRepository
  attr_reader :items
  def initialize(csv_file)
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    parse_file(content)
    # @items = content.map do |row|
    #   Item.new(row)
    # end
  end

  def parse_file(content)
    data = []
    content.each do |row|
      data << row[:id]
      data << BigDecimal.new(row[:unit_price].to_i)
      data << row[:created_at]
      create_item_object(data)
    end
  end

  def create_item_object(data)
    @all_items = []
    all_items << Item.new({
    id: data[0]

      })
  end

  def all
    items
  end

  def find_by_id(id_number)
    items.find do |item|
      item.id == id_number
    end
  end

  def find_by_name(input)
    items.find do |item|
      item.name.downcase == input.downcase
    end
  end

  def find_by_description(input)
    items.find_all do |item|
      item.description.downcase.include?(input.downcase)
    end
  end

  def find_all_by_price(input)
    items.find_all do |item|
      item.unit_price
    end
  end

  def find_all_by_price_in_range(low, high)
    items.find_all do |item|
      item.unit_price.between?(low, high)
    end
  end

  def find_all_by_merchant_id(input)
    items.find_all do |item|
      item.merchant_id == input
    end
  end
end
