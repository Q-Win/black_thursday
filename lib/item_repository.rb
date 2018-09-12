require_relative 'item'
require 'time'
require_relative './repositories'

class ItemRepository

  include Repositories

  attr_reader :collection

  def initialize
    @collection = []
  end

  def find_all_with_description(description)
    collection.find_all {|item| item.description.downcase.include? description.downcase }
  end

  def find_all_by_price(price)
    collection.find_all {|item| item.unit_price_to_dollars == price.to_f}
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_by_price_in_range(range)
    collection.find_all {|item| range.include?(item.unit_price_to_dollars)}
  end

  def find_all_by_merchant_id(merchant_id)
    merchant = collection.find_all {|item| item.merchant_id == merchant_id}
  end

  def create(attributes)
    max_id = (collection.max_by{|item| item.id}).id + 1
    attributes[:id] = max_id
    new_item = Item.new(attributes)
    add_object(new_item)
    new_item
  end

  def update(id, attributes)
    item = find_by_id(id)

    if find_by_id(id) == nil

    else
      attributes.each do |attribute|
        if (attribute[0] == :id || attribute[0] == :created_at || attribute[0] == :merchant_id)

        else
          item.send("#{attribute[0]}=",attribute[1])
        end
      end
      item.updated_at = Time.new
    end
  end

end
