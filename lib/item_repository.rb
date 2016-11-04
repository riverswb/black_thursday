require_relative '../lib/item'

class ItemRepository
  attr_reader :all

  def initialize(csv_file, parent = nil)
    @parent = parent
    content = CSV.open csv_file, headers: true, header_converters: :symbol
    item_parser(content)
  end

  def item_parser(content)
    @all = content.map do |row|
      Item.new(row, self)
    end
  end

  def inspect
    "#{self.class}#{@items.size}"
  end

  def find_by_id(id_number)
    all.find do |item|
      item.id.to_i == id_number
    end
  end

  def find_by_name(input)
    all.find do |item|
      item.name.downcase == input.downcase
    end
  end

  def find_all_with_description(input)
    all.find_all do |item|
      item.description.downcase.include?(input.downcase)
    end
  end

  def find_all_by_price(input)
    all.find_all do |item|
      item.unit_price_to_dollars == input.to_f
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(input)
    all.find_all do |item|
      item.merchant_id.to_i == input
    end
  end

  def find_merchant_by_id(merchant_id)
    @parent.find_merchant_by_id(merchant_id)
  end
end
