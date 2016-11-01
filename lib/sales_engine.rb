require 'csv'
require './lib/item_repository'
require './lib/file_loader'
require './lib/merchant_repository'

class SalesEngine

  def initialize(csv_files)
    @files = csv_files
  end

  def self.from_csv(csv_files)
    self.new(csv_files)
  end

  def items
    @item = ItemRepository.new(@files[:items])
  end

  def merchants
    @merchants = MerchantRepository.new(@files[:merchants])
  end
end
