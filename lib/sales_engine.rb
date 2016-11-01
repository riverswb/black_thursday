require 'csv'
require './lib/item_repository'
require './lib/file_loader'
require './lib/merchant_repository'

class SalesEngine
  # attr_reader :files

  def initialize(csv_files)
    @files = csv_files
    # @item_repository = ItemRepository.new(self)
  end

  def self.from_csv(csv_files)
    self.new(csv_files)
  end

  def items
    @item = ItemRepository.new(@files[:items])
    # item_repository.each do |row|
    #   id = row[:id]
    #   name = row[:name]
    #   description = row[:description]
    #   unit_price = row[:unit_price]
    #   merchant_id = row[:merchant_id]
    #   created_at = row[:created_at]
    #   updated_at = row[:updated_at]
    # end
  end

  def merchants
<<<<<<< HEAD
    @merchants = MerchantRepository.new(@files[:merchants])
  end

=======
    @merchant = MerchantRepository.new(@files[:merchants])
  end
>>>>>>> 43a217ac23a624366aea4655bc6abfb58ee0e263
  # def merchants
  #   merchants_repository = MerchantsRepository.new
  #   merchants_repository = CSV.read (csv_files[:merchants]), headers: true, header_converters: :symbol
  #   merchants_repository.each do |row|
  #     id = [:id]
  #     name = [:name]
  #     created_at = [:created_at]
  #     updated_at = [:updated_at]
  #   end
  # end
end
