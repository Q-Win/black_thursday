require_relative 'invoice'
require 'time'
require_relative './repositories'


class InvoiceRepository

    attr_reader :collection

include Repositories

  def initialize
    @collection = []
  end

  def find_all_by_customer_id(customer_id)
    @collection.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    @collection.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    @collection.find_all {|invoice| invoice.status == status}
  end

  def create(attributes)
    max_id = (collection.max_by{|invoice| invoice.id}).id + 1
    attributes[:id] = max_id
    new_item = Invoice.new(attributes)
    add_object(new_item)
    new_item
  end

  def update(id, attributes)
    invoice = find_by_id(id)

    if find_by_id(id) == nil

    else
      invoice.updated_at = Time.now
      invoice.status = attributes[:status]
    end
  end

end
