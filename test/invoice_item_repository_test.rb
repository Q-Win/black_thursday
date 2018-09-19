require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require 'bigdecimal'
require 'time'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_starts_with_an_empty_collection
    iir = InvoiceItemRepository.new

    assert_equal [], iir.all
  end

  def test_it_it_can_add_an_ii
    iir = InvoiceItemRepository.new
    ii= InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    iir.add_object(ii)

    assert_equal [ii], iir.all
  end

  def test_it_can_find_by_id
    iir = InvoiceItemRepository.new
    ii= InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    iir.add_object(ii)

    assert_equal ii, iir.find_by_id(6)
  end

  def test_it_can_find_all_by_item_id
    iir = InvoiceItemRepository.new
    ii= InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })
    ii2= InvoiceItem.new({
    :id => 7,
    :item_id => 7,
    :invoice_id => 9,
    :quantity => 2,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })
    ii3= InvoiceItem.new({
    :id => 8,
    :item_id => 8,
    :invoice_id => 10,
    :quantity => 5,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    iir.add_object(ii)
    iir.add_object(ii2)
    iir.add_object(ii3)

    assert_equal [ii,ii2], iir.find_all_by_item_id(7)
  end

  def test_it_can_find_all_by_invoice_id
    iir = InvoiceItemRepository.new
    ii= InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })
    ii2= InvoiceItem.new({
    :id => 7,
    :item_id => 7,
    :invoice_id => 9,
    :quantity => 2,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })
    ii3= InvoiceItem.new({
    :id => 8,
    :item_id => 8,
    :invoice_id => 9,
    :quantity => 5,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    iir.add_object(ii)
    iir.add_object(ii2)
    iir.add_object(ii3)

    assert_equal [ii2,ii3], iir.find_all_by_invoice_id(9)
  end

  def test_it_can_create_item_invoice
    iir = InvoiceItemRepository.new
    ii= InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    iir.add_object(ii)
    ii2 = iir.create({
    :item_id => 9,
    :invoice_id => 12,
    :quantity => 7,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_equal 7, ii2.id
    assert_equal [ii,ii2], iir.all
    assert_equal 12, ii2.invoice_id
  end

  def test_we_can_update_invoice_item
    iir = InvoiceItemRepository.new
    ii= InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    iir.add_object(ii)
    iir.update(6,{
    :id => 9,
    :item_id => 7,
    :invoice_id => 9,
    :quantity => 5,
    :unit_price => BigDecimal.new(11.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    assert_equal 11.99, ii.unit_price_to_dollars
    assert_equal 5, ii.quantity
    assert_equal 6, ii.id
    assert_equal 8, ii.invoice_id
  end

  def test_it_can_delete_invoice_item
    iir = InvoiceItemRepository.new
    ii= InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })
    ii2= InvoiceItem.new({
    :id => 7,
    :item_id => 7,
    :invoice_id => 9,
    :quantity => 2,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })
    ii3= InvoiceItem.new({
    :id => 8,
    :item_id => 8,
    :invoice_id => 10,
    :quantity => 5,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    iir.add_object(ii)
    iir.add_object(ii2)
    iir.add_object(ii3)
    iir.delete(7)

    assert_equal [ii,ii3], iir.all
  end

end
