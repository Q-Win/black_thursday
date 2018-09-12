require_relative "merchant"
require_relative './repositories'

class MerchantRepository

  attr_reader :collection

  include Repositories

  def initialize
    @collection = []
  end
  # def add_merchant(merchant)
  #   @collection << merchant
  # end

  # def all
  #   @collection
  # end

  # def find_by_id(id)
  #   collection.find {|merchant| merchant.id == id}
  # end

  # def find_by_name(name)
  #   collection.find {|merchant| merchant.name.downcase. == name.downcase}
  # end

  def find_all_by_name(name)
    all.find_all {|merchant| merchant.name.downcase.include? name.downcase}
  end

  def create(attributes)
    max_id = (collection.max_by{|merchant| merchant.id}.id) + 1
    m = Merchant.new({:id => max_id, :name => attributes[:name]})
    add_merchant(m)
    m
  end

  def update(id, attributes)
    if find_by_id(id) == nil

    else
      m = find_by_id(id)
      m.name = attributes[:name]
    end
  end

  # def delete(id)
  #   if find_by_id(id) == nil
  #
  #   else
  #     index = collection.find_index {|i| i.id == id}
  #     collection.delete_at(index)
  #   end
  # end

  # def inspect
  #   "#<#{self.class} #{@collection.size} rows>"
  # end
end
