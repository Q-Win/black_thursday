require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require 'bigdecimal'
require 'time'

class TransactionTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new

    assert_instance_of TransactionRepository, tr
  end

  def test_it_starts_with_an_empty_collection
    tr = TransactionRepository.new

    assert_equal [], tr.all
  end

  def test_we_can_add_a_transaction
    tr = TransactionRepository.new
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.add_object(t)

    assert_equal [t], tr.all
  end

  def test_we_can_find_by_id
    tr = TransactionRepository.new
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t2 = Transaction.new({
    :id => 7,
    :invoice_id => 9,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.add_object(t)
    tr.add_object(t2)

    assert_equal t2, tr.find_by_id(7)
  end

  def test_we_can_find_all_by_invoice_id
    tr = TransactionRepository.new
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t2 = Transaction.new({
    :id => 7,
    :invoice_id => 9,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t3 = Transaction.new({
    :id => 8,
    :invoice_id => 9,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.add_object(t)
    tr.add_object(t2)
    tr.add_object(t3)

    assert_equal [t2,t3], tr.find_all_by_invoice_id(9)
  end

  def test_we_can_find_all_by_credit_card_number
    tr = TransactionRepository.new
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "5242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t2 = Transaction.new({
    :id => 7,
    :invoice_id => 9,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t3 = Transaction.new({
    :id => 8,
    :invoice_id => 9,
    :credit_card_number => "5242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.add_object(t)
    tr.add_object(t2)
    tr.add_object(t3)

    assert_equal [t,t3], tr.find_all_by_credit_card_number("5242424242424242")
  end

  def test_we_can_find_all_by_result
    tr = TransactionRepository.new
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "5242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t2 = Transaction.new({
    :id => 7,
    :invoice_id => 9,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t3 = Transaction.new({
    :id => 8,
    :invoice_id => 9,
    :credit_card_number => "5242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "failure",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.add_object(t)
    tr.add_object(t2)
    tr.add_object(t3)

    assert_equal [t,t2], tr.find_all_by_result("success")
  end

  def test_we_can_create
    tr = TransactionRepository.new
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "5242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t2 = Transaction.new({
    :id => 7,
    :invoice_id => 9,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.add_object(t)
    tr.add_object(t2)
    t3 = tr.create({
      :id => 1,
      :invoice_id => 9,
      :credit_card_number => "5242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "failure",
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_equal [t,t2,t3], tr.all
    assert_equal 8, t3.id
  end

  def test_we_can_update
    tr = TransactionRepository.new
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "5242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    t2 = Transaction.new({
    :id => 7,
    :invoice_id => 9,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.add_object(t)
    tr.add_object(t2)
    tr.update(7,{
      :id => 1,
      :invoice_id => 9,
      :credit_card_number => "6242424242424242",
      :credit_card_expiration_date => "0223",
      :result => "failure",
      :created_at => Time.now,
      :updated_at => Time.now
      })
    assert_equal "6242424242424242", t2.credit_card_number
    assert_equal "0223", t2.credit_card_expiration_date
    assert_equal "failure", t2.result
  end
end
