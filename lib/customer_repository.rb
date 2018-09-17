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
    @collection.find_all {|customer| customer.first_name.downcase.include? first_name.downcase}
  end

  def find_all_by_last_name(last_name)
      @collection.find_all {|customer| customer.last_name.downcase.include? last_name.downcase}
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
      attributes.each do |attribute|
        if (attribute[0] == :id || attribute[0] == :created_at)

        else
          customer.send("#{attribute[0]}=",attribute[1])
        end
      end
    customer.updated_at = Time.new
    end

  end

end
