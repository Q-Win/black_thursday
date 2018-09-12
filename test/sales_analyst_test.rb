require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items          => "./data/items.csv",
      :merchants      => "./data/merchants.csv",
      })
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_calculate_average
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_return_hash_of_solf_items
    assert_instance_of Hash, @sa.items_per_merchant
    assert_equal 475, @sa.items_per_merchant.keys.length
    assert_equal [12334141, 1], @sa.items_per_merchant.first
  end

  def test_it_returns_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end
end
