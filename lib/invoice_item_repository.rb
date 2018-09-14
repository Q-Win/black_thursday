require 'time'
require_relative './repositories'

class InvoiceItemRepository
  include Repositories

  attr_reader   :collection

  def initialize
    @collection = []
  end

  def find_all_by_item_id(item_id)
    @collection.find_all {|invoice| invoice.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @collection.find_all {|invoice| invoice.invoice_id == invoice_id}
  end

  def create(attributes)
    max_id = (collection.max_by{|invoice| invoice.id}).id + 1
    attributes[:id] = max_id
    new_item = InvoiceItem.new(attributes)
    add_object(new_item)
    new_item
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)

    if find_by_id(id) == nil

    else
      invoice_item.updated_at = Time.now
      invoice_item.quantity = attributes[:quantity]
      invoice_item.unit_price = BigDecimal.new(attributes[:unit_price],4)
    end
  end

end
