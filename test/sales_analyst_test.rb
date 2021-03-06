require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items          => "./data/items.csv",
      :merchants      => "./data/merchants.csv",
      :invoices       => "./data/invoices.csv",
      :invoice_items  => "./data/invoice_items.csv",
      :transactions   => "./data/transactions.csv",
      :customers      => "./data/customers.csv"
      })
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_calculate_average
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_return_hash_of_sold_items
    assert_instance_of Hash, @sa.items_per_merchant
    assert_equal 475, @sa.items_per_merchant.keys.length
    assert_equal [12334141, 1], @sa.items_per_merchant.first
  end

  def test_it_returns_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_array_of_most_selling_merchant_ids
    assert_instance_of Array, @sa.merchant_id_with_high_item_count
    assert_equal 52, @sa.merchant_id_with_high_item_count.length
    assert_equal 12334195, @sa.merchant_id_with_high_item_count.first
    assert_equal 12334522, @sa.merchant_id_with_high_item_count.last
  end


  def test_it_returns_an_array_of_merchants_that_sell_the_most_items
    assert_instance_of Array, @sa.merchants_with_high_item_count
    assert_instance_of Merchant, @sa.merchants_with_high_item_count.first
    assert_equal 52, @sa.merchants_with_high_item_count.length
  end

  def test_the_avg_item_price_for_a_given_merchant
    expected = BigDecimal.new(31.50, 4)
    assert_equal expected, @sa.average_item_price_for_merchant(12334159)
  end

  def test_it_can_return_average_unit_price_for_another_given_merchant
    expected = BigDecimal.new(16.66, 4)
    assert_equal expected, @sa.average_item_price_for_merchant(12334105)
  end

  def test_it_returns_all_merchants_with_pending_invoices
    assert_equal 467, @sa.merchants_with_pending_invoices.count
    assert_instance_of Merchant, @sa.merchants_with_pending_invoices.first
  end

  def test_it_returns_true_if_invoice_is_pending
    assert @sa.pending_invoice?(9)
    refute @sa.pending_invoice?(1)
  end


end
