require 'time'
require_relative './repositories'

class TransactionRepository
  include Repositories

  def initialize
    @collection = []
  end

  def find_all_by_invoice_id(invoice_id)
    @collection.find_all {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    @collection.find_all {|transaction| transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    @collection.find_all {|transaction| transaction.result == result}
  end

  def create(attributes)
    max_id = (@collection.max_by{|transaction| transaction.id}).id + 1
    attributes[:id] = max_id
    new_item = Transaction.new(attributes)
    add_object(new_item)
    new_item
  end

  def update(id, attributes)
    transaction = find_by_id(id)

    if find_by_id(id) == nil

    else
      transaction.updated_at = Time.now
      transaction.credit_card_number = attributes[:credit_card_number]
      transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date]
      transaction.result = attributes[:result]
    end
  end

end
