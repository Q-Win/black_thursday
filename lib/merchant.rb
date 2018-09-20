require_relative "merchant_repository"
class Merchant

  attr_reader :created_at, :updated_at

  attr_accessor :name, :id

  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @updated_at = merchant_hash[:updated_at]
    @created_at = merchant_hash[:created_at]
  end

end
