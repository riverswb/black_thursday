require 'csv'
require_relative '../lib/item_repository'
require_relative '../lib/file_loader'
require_relative '../lib/merchant_repository'

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
