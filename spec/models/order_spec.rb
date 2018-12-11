require 'rails_helper'

describe 'After creation' do

  before :each do

    cat1 = Category.find_or_create_by! name: 'Apparel'
    cat2 = Category.find_or_create_by! name: 'Misc'

    @product1 = cat1.products.create!(
      name: 'Moon Boots',
      description: 'Sweet boots',
      quantity: 10,
      price: 135.00
    )

    @product2 = cat2.products.create!(
      name: 'Funky Basket',
      description: 'This basket is full of funk',
      quantity: 5,
      price: 25.50
    )

    @product3 = cat2.products.create!(
      name: 'Magnet',
      description: 'It depicts a serene ocean scene',
      quantity: 8,
      price: 4.99
    )

  end

  it 'deducts quantity from products based on their line item quantities' do

    @order = Order.create(
      email: 'test@test.com',
      total_cents: 0,
      stripe_charge_id: 123
    )

    @order.line_items.create(
      product: @product1,
      quantity: 2,
      item_price: @product1.price,
      total_price: @product1.price * 2
    )

    @order.line_items.create(
      product: @product2,
      quantity: 1,
      item_price: @product2.price,
      total_price: @product2.price
    )

    @order.save!

    @product1.reload
    @product2.reload
    @product3.reload

    expect(@product2.quantity).to eq 4

  end

  it 'does not deduct quantity from products that are not in the order' do

    expect(@product3.quantity).to eq 8

  end

end
