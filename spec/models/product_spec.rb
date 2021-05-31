require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "successfully saves" do
      @product = Product.new

      @product.name = 'Product Name'
      @product.price = 100
      @product.quantity = 1
      @product.category_id = 1

      @product.save

      expect(@product).to be_present
    end

    it "validates name" do
    end

    it "validates price" do
    end

    it "validates quantity" do
    end

    it "validates category" do
    end

  end
end