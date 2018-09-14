require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceTest < Minitest::Test

  def test_it_exists
    i = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now,
  :updated_at  => Time.now,
  })

  assert_instance_of Invoice, i
  end

  def test_it_has_attributes
    i = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now,
  :updated_at  => Time.now,
  })

  assert_equal 6, i.id
  assert_equal 7, i.customer_id
  assert_equal 8, i.merchant_id
  assert_equal "pending", i.status
  assert_equal Time.now.to_s, i.created_at.to_s
  assert_equal Time.now.to_s, i.updated_at.to_s
  end

end
