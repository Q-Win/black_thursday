require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_it_has_no_merchants_by_default
    mr = MerchantRepository.new

    assert_equal [], mr.collection
  end

  def test_we_can_add_merchants
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_object(m)

    assert_equal [m], mr.collection

    mr.add_object(m2)

    assert_equal [m,m2], mr.collection

  end

  def test_we_return_all_the_merchants
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_object(m)
    mr.add_object(m2)

    assert_equal [m,m2], mr.all

  end

  def test_we_can_find_merchant_by_id
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_object(m)
    mr.add_object(m2)

    actual = mr.find_by_id(6).name

    assert_equal "Basement", actual
    assert_equal 6, mr.find_by_id(6).id

  end

  def test_we_can_find_merchant_by_name
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_object(m)
    mr.add_object(m2)

    actual = mr.find_by_name("basement").name

    assert_equal "Basement", actual

  end

  def test_we_can_find_all_merchants_by_name
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})
    m3 = Merchant.new({:id => 7, :name => "BaseMent"})
    m4 = Merchant.new({:id => 8, :name => "bAsEmEnT"})

    mr.add_object(m)
    mr.add_object(m2)
    mr.add_object(m3)
    mr.add_object(m4)

    actual = mr.find_all_by_name("base")

    assert_equal [m2,m3,m4], actual

  end

  def test_we_can_create_new_merchant
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})
    m3 = Merchant.new({:id => 7, :name => "BaseMent"})
    m4 = Merchant.new({:id => 8, :name => "bAsEmEnT"})

    mr.add_object(m)
    mr.add_object(m2)
    mr.add_object(m3)
    mr.add_object(m4)
    m5 = mr.create({:id => 8, :name => "bAsEmEnT"})

    actual = m5.id
    assert_equal 9, actual
  end

  def test_we_can_update_merchant

    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})

    mr.add_object(m)
    mr.add_object(m2)
    mr.update(6, {:id => 6, :name => "Pawn Shop"})

    actual = m2.name
    assert_equal "Pawn Shop", actual
  end

  def test_we_can_delete_merchant
    mr = MerchantRepository.new
    m = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 6, :name => "Basement"})
    m3 = Merchant.new({:id => 7, :name => "BaseMent"})
    m4 = Merchant.new({:id => 8, :name => "bAsEmEnT"})

    mr.add_object(m)
    mr.add_object(m2)
    mr.add_object(m3)
    mr.add_object(m4)
    mr.delete(6)

    assert_equal [m,m3,m4], mr.collection

    mr.delete(5)

    assert_equal [m3,m4], mr.collection
  end


end
