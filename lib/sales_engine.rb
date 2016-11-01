require 'csv'
require './lib/item_repository'
require './lib/file_loader'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :items,
              :merchants
  def initialize(csv_files)
    @items = ItemRepository.new(csv_files[:items])
    @merchants = MerchantRepository.new(csv_files[:merchants])
  end

  def self.from_csv(csv_files)
    self.new(csv_files)
  end
end
