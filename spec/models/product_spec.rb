require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: 'Sample Category')
    end

    it 'should save successfully with all required fields set' do
      product = Product.new(name: 'Test Product', price: 25, quantity: 10, category: @category)
      expect(product.save).to be_truthy
    end

    it 'should not save without a name' do
      product = Product.new(name: nil, price: 25, quantity: 10, category: @category)
      product.valid?
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save without a price' do
      product = Product.new(name: 'Test Product', price: nil, quantity: 10, category: @category)
      product.valid?
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save without a quantity' do
      product = Product.new(name: 'Test Product', price: 25, quantity: nil, category: @category)
      product.valid?
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without a category' do
      product = Product.new(name: 'Test Product', price: 25, quantity: 10, category: nil)
      product.valid?
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end