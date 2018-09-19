require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceTest < Minitest::Test

  def test_it_exists
    ir = InvoiceRepository.new

    assert_instance_of InvoiceRepository, ir
  end

  def test_it_starts_with_an_empty_collection
    ir = InvoiceRepository.new

    assert_equal [], ir.all
  end

  def test_it_can_add_an_invoice
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)

    assert_equal [i], ir.all
  end

  def test_it_can_find_by_id
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)

    assert_equal i, ir.find_by_id(6)
  end

  def test_it_can_find_all_by_customer_id
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i2 = Invoice.new({
    :id          => 7,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i3 = Invoice.new({
    :id          => 1,
    :customer_id => 2,
    :merchant_id => 3,
    :status      => "complete",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)
    ir.add_object(i2)
    ir.add_object(i3)

    assert_equal [i,i2], ir.find_all_by_customer_id(7)
  end

  def test_it_can_find_all_by_merchant_id
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i2 = Invoice.new({
    :id          => 7,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i3 = Invoice.new({
    :id          => 1,
    :customer_id => 2,
    :merchant_id => 3,
    :status      => "complete",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)
    ir.add_object(i2)
    ir.add_object(i3)

    assert_equal [i,i2], ir.find_all_by_merchant_id(8)
  end

  def test_it_can_find_all_by_status
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i2 = Invoice.new({
    :id          => 7,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i3 = Invoice.new({
    :id          => 1,
    :customer_id => 2,
    :merchant_id => 3,
    :status      => "complete",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)
    ir.add_object(i2)
    ir.add_object(i3)

    assert_equal [i,i2], ir.find_all_by_status("pending")
  end

  def test_we_can_create_new_invoice
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)
    i3 = ir.create({
    :customer_id => 2,
    :merchant_id => 3,
    :status      => "complete",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    assert_equal "complete", i3.status
    assert_equal 7, i3.id
  end

  def test_we_can_update_invoice
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)
    ir.update(6,{:status => "complete"})

    assert_equal "complete", i.status
  end

  def test_it_can_delete_invoice
    ir = InvoiceRepository.new
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i2 = Invoice.new({
    :id          => 7,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })
    i3 = Invoice.new({
    :id          => 1,
    :customer_id => 2,
    :merchant_id => 3,
    :status      => "complete",
    :created_at  => Time.now,
    :updated_at  => Time.now,
    })

    ir.add_object(i)
    ir.add_object(i2)
    ir.add_object(i3)
    ir.delete(1)

    assert_equal [i,i2], ir.all
  end



end
