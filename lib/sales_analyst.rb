class SalesAnalyst
  attr_reader :items, :merchants, :invoice_items, :invoices

  def initialize(items, merchants, invoice_items, invoices)
    @items = items
    @merchants = merchants
    @invoice_items = invoice_items
    @invoices = invoices

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
    merchant_ids.inject(Hash.new(0)) do |item_counts, merchant_id|
      item_counts[merchant_id] += 1
      item_counts
    end
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    num_diff_mean = items_per_merchant.values.map{|number|number - mean}
    num_diff_squared = num_diff_mean.map{|number|number ** 2}
    sum_of_num_diff_squared = num_diff_squared.inject(0){|sum, diff|sum + diff}
    average_difference = sum_of_num_diff_squared / (merchants.all.length - 1)
    return Math.sqrt(average_difference).round(2)
  end

  def merchant_id_with_high_item_count
    items_per_merchant.keys.inject([]) do |loaded_merchants, merchant_id|
      items = items_per_merchant[merchant_id]
      if items > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
        loaded_merchants << merchant_id.to_s
      end
      loaded_merchants
    end
  end

  def merchants_with_high_item_count
    merchant_id_with_high_item_count.inject([]) do |loaded_merchants, merchant_id|
      loaded_merchants << merchants.find_by_id(merchant_id.to_i)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    total_items_for_merchant = items.all.find_all{|item|item.merchant_id == merchant_id.to_s}
    array_of_prices = total_items_for_merchant.map{|item|item.unit_price}
    return average(array_of_prices)
  end

  def average_average_price_per_merchant
    sum_of_averages = merchants.all.inject(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id.to_s)
    end
    return (sum_of_averages / merchants.all.length).round(2)
  end


  # def average_item_price_standard_deviation
  #  array_of_prices = items.all.map{|item|item.unit_price}
  #  return standard_deviation(array_of_prices)
  # end

  def average(array)
    sum_of_elements = array.inject(0){|sum, element|sum + element}
    return (sum_of_elements / array.length).round(2)
  end
end
