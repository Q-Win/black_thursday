require 'time'
require_relative './repositories'
require_relative './transaction'
require 'pry'

class TransactionRepository
  include Repositories

  attr_reader   :collection

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
      attributes.each do |attribute|
        if (attribute[0] == :id || attribute[0] == :invoice_id || attribute[0] == :created_at)

        else
          transaction.send("#{attribute[0]}=",attribute[1])
        end
      end
    transaction.updated_at = Time.new
    end

  end

end
