class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent
  def initialize(args, parent = nil)
    @id = args[:id].to_i
    @first_name = args[:first_name]
    @last_name = args[:last_name]
    @created_at = Time.parse(args[:created_at])
    @updated_at = Time.parse(args[:updated_at])
    @parent = parent
  end
end
