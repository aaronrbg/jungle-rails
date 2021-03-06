require 'rails_helper'

RSpec.describe Product, type: :model do
  
  before :all do
    @cat = Category.find_or_create_by! name: 'Apparel'
  end

  before :each do
    @product = @cat.products.new(
      name: 'Item',
      price_cents: 100,
      quantity: 1
    )
  end

  describe 'Validations' do

    it "is valid with valid attributes" do
      expect(@product).to be_valid
    end
  
    it "is not valid without a name" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq 'Name can\'t be blank'
      expect(@product).to_not be_valid
    end
  
    it "is not valid without a price" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq 'Price cents is not a number'
      expect(@product).to_not be_valid
    end
  
    it "is not valid without a quantity" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq 'Quantity can\'t be blank'
      expect(@product).to_not be_valid
    end
  
    it "is not valid without a category" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq 'Category can\'t be blank'
      expect(@product).to_not be_valid
    end
  
  end

end
