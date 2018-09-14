require "csv"
require_relative "merchant_repository"
require_relative "item_repository"
require_relative "invoice_repository"
require 'bigdecimal'
require 'pry'

class SalesEngine
  attr_accessor :merchants,
                :items,
                :invoices
  def initialize
    @merchants = nil
    @items = nil
    @invoices = nil
  end

  def self.from_csv(repos)
    se = SalesEngine.new
    se.merchants = se.pull_merchant_repository(repos[:merchants])
    se.items = se.pull_item_repository(repos[:items])
    se.invoices = se.pull_invoice_repository(repos[:invoices])

   return se
  end

  def pull_merchant_repository(file_path_merchant)
    mr = MerchantRepository.new
    total_merchants = CSV.read(file_path_merchant, headers: true, header_converters: :symbol)

    total_merchants.each do |merchant|
      m = Merchant.new({:id => merchant[:id].to_i, :name => merchant[:name]})
      mr.add_object(m)
    end
    mr
  end


  def pull_item_repository(file_path_item)
    it = ItemRepository.new
    total_items = CSV.read(file_path_item, headers: true, header_converters: :symbol)
    total_items.each do |item|
      i = Item.new({:id => item[:id].to_i, :name => item[:name], :description => item[:description],
                    :unit_price => BigDecimal.new(item[:unit_price].to_f/100,4), :created_at => Time.parse(item[:created_at]),
                    :updated_at => Time.parse(item[:updated_at]), :merchant_id => item[:merchant_id].to_i})
      it.add_object(i)
    end
    return it
  end

  def pull_invoice_repository(file_path_item)
    in_r = InvoiceRepository.new
    total_invoices = CSV.read(file_path_item, headers: true, header_converters: :symbol)
    total_invoices.each do |invoice|
      i = Invoice.new({:id => invoice[:id].to_i, :customer_id => invoice[:customer_id].to_i, :merchant_id => invoice[:merchant_id].to_i,
                    :status => invoice[:status].to_sym, :created_at => Time.parse(invoice[:created_at]),
                    :updated_at => Time.parse(invoice[:updated_at])})
      in_r.add_object(i)
    end
    return in_r
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
