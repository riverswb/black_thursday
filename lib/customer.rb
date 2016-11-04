class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(args)
    @id = args[:id]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
