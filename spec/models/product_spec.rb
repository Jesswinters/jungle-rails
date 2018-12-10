require 'rails_helper'

RSpec.describe Product, type: :model do

  before :each do
    @category = Category.create! name: 'Apparel'

    @product = @category.products.create!({
      name:  'Cool scraf',
      price: 30,
      quantity: 4
    })
  end

  describe 'Validations' do

    it 'is not valid without a name' do
      @product.name = nil

      expect(@product).to_not be_valid
    end

    it 'is not valid without a price' do
      @product.price_cents = nil

      expect(@product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      @product.quantity = nil

      expect(@product).to_not be_valid
    end

    it 'is not valid without a category' do
      @product.category = nil

      expect(@product).to_not be_valid
    end

  end

end
