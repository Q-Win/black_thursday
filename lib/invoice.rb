class Invoice

  attr_reader :id, :customer_id, :merchant_id,
              :created_at

  attr_accessor :status, :updated_at

  def initialize(invoice_hash)
    @id = invoice_hash[:id]
    @customer_id = invoice_hash[:customer_id]
    @merchant_id = invoice_hash[:merchant_id]
    @status = invoice_hash[:status].to_sym
    @created_at = invoice_hash[:created_at]
    @updated_at = invoice_hash[:updated_at]
  end

end
