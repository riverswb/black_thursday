class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at
  def initialize(args)
    @id = args[:id]
    @invoice_id = args[:invoice_id]
    @credit_card_number = args[:credit_card_number]
    @credit_card_expiration_date = args[:credit_card_expiration_date]
    @result = args[:result]
    @created_at = args[:created_at]
    @updated_at = args[:updated_at]
  end
end
