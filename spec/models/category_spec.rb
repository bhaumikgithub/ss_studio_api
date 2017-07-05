# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:category) { FactoryGirl.create(:category) }

  context 'Success' do
    let!(:category1) { FactoryGirl.create(:category, category_name: 'category 1') }
    it 'orders by category name' do
      # category = Category.new(category_name: "album")
      expect(category1).to be_valid
    end
  end

  context 'Validate Category' do
    it 'should validate presence' do
      # category = Category.new
      category.category_name = '' # invalid state
      category.valid? # run validations
      expect(category.errors[:category_name]).to include("can't be blank")
    end
  end

  context 'Validation Presence' do
    let!(:category2) { FactoryGirl.build(:category, category_name: '') }
    it 'is not valid without a category_name' do
      # category = Category.create(category_name: nil)
      # puts "=======#{category2.inspect}=========="
      expect(category2).to_not be_valid
    end
  end
end
