require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require 'bigdecimal'
require 'time'

class TransactionTest < Minitest::Test

  def test_it_exists
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_instance_of Transaction, t
  end

  def test_it_has_attributes
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_equal 6, t.id
  end

end
