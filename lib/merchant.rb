class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(args)
    @id = args[:id]
    @name = args[:name]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
