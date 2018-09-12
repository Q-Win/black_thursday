require_relative "merchant"
require_relative './repositories'

class MerchantRepository

  attr_reader :collection

  include Repositories

  def initialize
    @collection = []
  end

  def find_all_by_name(name)
    all.find_all {|merchant| merchant.name.downcase.include? name.downcase}
  end

  def create(attributes)
    max_id = (collection.max_by{|merchant| merchant.id}.id) + 1
    m = Merchant.new({:id => max_id, :name => attributes[:name]})
    add_object(m)
    m
  end

  def update(id, attributes)
    if find_by_id(id) == nil

    else
      m = find_by_id(id)
      m.name = attributes[:name]
    end
  end

end
