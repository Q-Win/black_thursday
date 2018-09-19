require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'
require 'bigdecimal'
require 'time'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new

    assert_instance_of CustomerRepository, cr
  end

  def test_it_starts_with_an_empty_collection
    cr = CustomerRepository.new

    assert_equal [], cr.all
  end

  def test_we_add_a_customer
    cr = CustomerRepository.new
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    cr.add_object(c)

    assert_equal [c], cr.all
  end

  def test_we_can_find_all_by_first_name
    cr = CustomerRepository.new
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    c2 = Customer.new({
    :id => 7,
    :first_name => "Bob",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    c3 = Customer.new({
    :id => 8,
    :first_name => "Joan",
    :last_name => "Jones",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    cr.add_object(c)
    cr.add_object(c2)
    cr.add_object(c3)

    assert_equal [c,c3], cr.find_all_by_first_name("Joan")
  end

  def test_we_can_find_all_by_last_name
      cr = CustomerRepository.new
      c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      })
      c2 = Customer.new({
      :id => 7,
      :first_name => "Bob",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      })
      c3 = Customer.new({
      :id => 8,
      :first_name => "Joan",
      :last_name => "Jones",
      :created_at => Time.now,
      :updated_at => Time.now
      })

      cr.add_object(c)
      cr.add_object(c2)
      cr.add_object(c3)

      assert_equal [c,c2], cr.find_all_by_last_name("Clarke")
  end

  def test_we_can_create
    cr = CustomerRepository.new
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    c2 = Customer.new({
    :id => 7,
    :first_name => "Bob",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    cr.add_object(c)
    cr.add_object(c2)
    c3 = cr.create({
    :id => 1,
    :first_name => "Joan",
    :last_name => "Jones",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_equal [c,c2,c3], cr.all
  end

  def test_we_can_update
    cr = CustomerRepository.new
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    c2 = Customer.new({
    :id => 7,
    :first_name => "Bob",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    c3 = Customer.new({
    :id => 8,
    :first_name => "Joan",
    :last_name => "Jones",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    cr.add_object(c)
    cr.add_object(c2)
    cr.add_object(c3)
    cr.update(8,{
      :id => 8,
      :first_name => "Bobert",
      :last_name => "Steves",
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_equal "Bobert", c3.first_name
    assert_equal "Steves", c3.last_name
  end

  def test_we_can_delete
    cr = CustomerRepository.new
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    c2 = Customer.new({
    :id => 7,
    :first_name => "Bob",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    c3 = Customer.new({
    :id => 8,
    :first_name => "Joan",
    :last_name => "Jones",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    cr.add_object(c)
    cr.add_object(c2)
    cr.add_object(c3)
    cr.delete(7)

    assert_equal [c,c3], cr.all
  end

end
