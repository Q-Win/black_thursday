class SalesAnalyst
  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

  def average_items_per_merchant
    number_of_items = items.all.length.to_f
    number_of_merchants = merchants.all.length
    average = (number_of_items / number_of_merchants).round(2)
    return average
  end

  def items_per_merchant
    merchant_ids = items.all.map{|item|item.merchant_id}
    item_totals = Hash.new(0)
    merchant_ids.each{|merchant_id|item_totals[merchant_id] += 1}
    return item_totals
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    num_diff_mean = items_per_merchant.values.map{|number|number - mean}
    num_diff_squared = num_diff_mean.map{|number|number ** 2}
    sum_of_num_diff_squared = num_diff_squared.inject(0){|sum, diff|sum + diff}
    average_difference = sum_of_num_diff_squared / (merchants.all.length - 1)
    return Math.sqrt(average_difference).round(2)
  end

end
