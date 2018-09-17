require 'time'
require_relative './repositories'
require_relative './customer'

class CustomerRepository

  include Repositories

  attr_reader   :collection

  def initialize
    @collection = []
  end

  def find_all_by_first_name(first_name)
    @collection.find_all {|customer| customer.first_name == first_name}
  end

  def find_all_by_last_name(last_name)
      @collection.find_all {|customer| customer.last_name == last_name}
  end

  def create(attributes)
    max_id = (@collection.max_by{|customer| customer.id}).id + 1
    attributes[:id] = max_id
    new_item = Customer.new(attributes)
    add_object(new_item)
    new_item
  end

  def update(id, attributes)
    customer = find_by_id(id)

    if find_by_id(id) == nil

    else
      customer.updated_at = Time.now
      customer.first_name = attributes[:first_name]
      customer.last_name = attributes[:last_name]
    end
  end

end
