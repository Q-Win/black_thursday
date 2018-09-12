module Repositories

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

  def all
    @collection
  end

  def add_merchant(object)
    @collection << object
  end

  def find_by_id(id)
    collection.find {|object| object.id == id}
  end

  def find_by_name(name)
    collection.find {|object| object.name.downcase. == name.downcase}
  end

  def delete(id)
    if find_by_id(id) == nil

    else
      index = collection.find_index {|i| i.id == id}
      collection.delete_at(index)
    end
  end

end
