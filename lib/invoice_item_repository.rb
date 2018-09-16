require 'time'
require_relative './repositories'
require_relative './invoice_item'

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
    item = find_by_id(id)

    if find_by_id(id) == nil

    else
      attributes.each do |attribute|
        if (attribute[0] == :id || attribute[0] == :item_id || attribute[0] == :invoice_id || attribute[0] == :created_at)

        else
          item.send("#{attribute[0]}=",attribute[1])
        end
      end
    item.updated_at = Time.new
    end

  end

end
