require 'pry'

class SalesAnalyst
  attr_reader :items, :merchants, :invoice_items, :invoices, :transactions, :customers

  def initialize(items, merchants, invoice_items, invoices, transactions, customers)
    @items = items
    @merchants = merchants
    @invoice_items = invoice_items
    @invoices = invoices
    @transactions = transactions
    @customers = customers
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

  def invoices_per_merchant
    merchant_ids = invoices.all.map{|invoice|invoice.merchant_id}
    merchant_ids.inject(Hash.new(0)) do |invoice_counts, merchant_id|
      invoice_counts[merchant_id] += 1
      invoice_counts
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
        loaded_merchants << merchant_id
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
    total_items_for_merchant = items.all.find_all{|item|item.merchant_id == merchant_id}
    array_of_prices = total_items_for_merchant.map{|item|item.unit_price}
    return average(array_of_prices)
  end

  def average_average_price_per_merchant
    sum_of_averages = merchants.all.inject(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    return (sum_of_averages / merchants.all.length).round(2)
  end

  def average(array)
    sum_of_elements = array.inject(0){|sum, element|sum + element}
    return (sum_of_elements / array.length).round(2)
  end

  def average_item_price
    array_of_prices = items.all.map{|item|item.unit_price}
    return average(array_of_prices)
  end

  def average_item_price_standard_deviation
    array_of_prices = items.all.map{|item|item.unit_price}
    return standard_deviation(array_of_prices)
  end

  def standard_deviation(array)
   mean = average(array)
   diff_from_mean = array.map{|element|element - mean}
   diff_squared = diff_from_mean.map{|difference|difference ** 2}
   sum_of_diff_squared = diff_squared.inject(0){|sum, diff|sum + diff}
   average_diff = sum_of_diff_squared / (items.all.length - 1)
   standard_deviation = Math.sqrt(average_diff)
   standard_deviation_length = standard_deviation.to_i.to_s.length + 2
   return BigDecimal.new(standard_deviation, standard_deviation_length)
 end

  def golden_items
    two_std = average_item_price + (average_item_price_standard_deviation * 2)
    return items.all.find_all{|item|item.unit_price > two_std}
  end

  def average_invoices_per_merchant
    number_of_invoices = invoices.all.length.to_f
    number_of_merchants = merchants.all.length
    average = (number_of_invoices / number_of_merchants).round(2)
    return average
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    num_diff_mean = invoices_per_merchant.values.map{|number|number - mean}
    num_diff_squared = num_diff_mean.map{|number|number ** 2}
    sum_of_num_diff_squared = num_diff_squared.inject(0){|sum, diff|sum + diff}
    average_difference = sum_of_num_diff_squared / (merchants.all.length - 1)
    return Math.sqrt(average_difference).round(2)

  end

  def top_merchants_by_invoice_count
    two_std = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    return merchants.all.find_all{|merchant| invoices_per_merchant[merchant.id]> two_std}
  end

  def bottom_merchants_by_invoice_count
    two_std = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    return merchants.all.find_all{|merchant| invoices_per_merchant[merchant.id]< two_std}
  end

  def top_days_by_invoice_count
    mean = @invoices.all.count/7
    weekday_count_hash = @invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
    invoices_by_day = weekday_count_hash.values.map do |invoices|
      invoices.count
    end

    day_nums = weekday_count_hash.find_all do |weekday, invoices|
      invoices.count > mean + average_invoices_per_day_standard_deviation(invoices_by_day)
    end.to_h.keys
  end

  def average_invoices_per_day_standard_deviation(invoices_by_day)
    mean = @invoices.all.count/7
    num_diff_mean = invoices_by_day.map{|number|number - mean}
    num_diff_squared = num_diff_mean.map{|number|number ** 2}
    sum_of_num_diff_squared = num_diff_squared.inject(0){|sum, diff|sum + diff}
    average_difference = sum_of_num_diff_squared / (invoices_by_day.length - 1)
    return Math.sqrt(average_difference).round(2)

  end

  def invoice_status(status)
    all_by_status = @invoices.all.find_all {|invoice| invoice.status == status}
     (((all_by_status.length.to_f)/(@invoices.all.count)) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
   transactions = @transactions.find_all_by_invoice_id(invoice_id)
   if transactions.length == 0
     false
   else
     transactions.any? { |transaction| transaction.result == :success }
   end
  end

  def invoice_total(invoice_id)
    invoice_item = @invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_item.inject(0) do |sum, invoice|
      sum + (invoice.unit_price * invoice.quantity)
    end
  end

  def total_revenue_by_date(date)
    invoices = @invoices.all.find_all {|invoice| invoice.created_at == date}
    invoices.inject(0)  {|sum, invoice| sum +  invoice_total(invoice.id)}
  end


  def all_transactions_for_invoice(invoice_id)
     transactions.collection.find_all do |transaction|
       transaction.invoice_id == invoice_id
    end
  end

  def calculate_merchants_revenue
    merchant_revenue_array = []
    @merchants.all.each do |merchant|
      merchant_hash = {}
      total_revenue = 0
      @invoices.all.each do |invoice|
        if invoice.merchant_id == merchant.id
            if invoice_paid_in_full?(invoice.id) == true
            total_revenue += invoice_total(invoice.id).to_f
          end
        end
      end
     merchant_hash[:id] = merchant.id
     merchant_hash[:revenue] = total_revenue
     merchant_revenue_array << merchant_hash
   end
   merchant_revenue_array
  end

  def merchants_ranked_by_revenue
    merchant_revenue_array = calculate_merchants_revenue

    sorted = merchant_revenue_array.sort_by {|hash| hash[:revenue]}.reverse
    sorted_array = sorted.map do |hash|
      @merchants.find_by_id(hash[:id])
    end
  end

  def top_revenue_earners(x = 20)
    merchant_revenue_array = calculate_merchants_revenue

    sorted = merchant_revenue_array.max_by(x) {|hash| hash[:revenue]}
    sorted_array = sorted.map do |hash|
      @merchants.find_by_id(hash[:id])
    end
  end

  def revenue_by_merchant(merchant_id)
    total_revenue = 0
    @invoices.all.each do |invoice|
      if invoice.merchant_id == merchant_id
        if invoice_paid_in_full?(invoice.id) == true
          total_revenue += invoice_total(invoice.id).to_f
        end
      end
    end

    BigDecimal.new(total_revenue,5)
  end

  def merchants_with_only_one_item
    merchant_hash = {}
    merchant_array = []
    @merchants.all.each do |merchant|
      merchant_hash[merchant.id] = 0
      @items.all.each do |item|
        if merchant.id == item.merchant_id
          merchant_hash[merchant.id] +=1
        end
      end
      if merchant_hash[merchant.id] < 2
        merchant_array << merchant
      end
    end
    merchant_array
  end

  def pending_invoice?(invoice_id)
    all_transactions_for_invoice(invoice_id).each do |transaction|
      if transaction.result == :success
        return false
      end
    end
    return true
  end

  def merchants_ids_with_pending_invoices
    invoices.collection.inject([]) do |merchant_id_array, invoice|
      if pending_invoice?(invoice.id)
        merchant_id_array << invoice.merchant_id
      end
      merchant_id_array
    end
  end

  def merchants_with_pending_invoices
    merchants_ids_with_pending_invoices.uniq.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)


  end
end
