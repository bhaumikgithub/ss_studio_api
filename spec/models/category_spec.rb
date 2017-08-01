# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:category) { FactoryGirl.create(:category) }

  context 'Success' do
    let!(:category1) { FactoryGirl.create(:category, category_name: 'category 1') }
    it 'orders by category name' do
      expect(category1).to be_valid
    end
  end

  context 'Validate Category' do
    it 'should validate presence' do
      category.category_name = '' # invalid state
      category.valid? # run validations
      expect(category.errors[:category_name]).to include("can't be blank")
    end
  end

  context 'Validation Presence' do
    let!(:category2) { FactoryGirl.build(:category, category_name: '') }
    it 'is not valid without a category_name' do
      expect(category2).to_not be_valid
    end
  end

  describe 'category name uniqueness' do
    before { FactoryGirl.create :category, category_name: 'test' }
    let(:category) { FactoryGirl.build :category, category_name: 'test' }
    it 'must be unique' do
      category.valid?
      expect(category.errors[:category_name]).to be == ['has already been taken']
    end
  end

  describe 'Category' do
    let(:status) do {
      inactive: 0, active: 1
      }
    end
    subject { described_class.new }
    it 'has valid a status' do
      status.each do |type, value|
        subject.status = value
        subject.save
        expect(subject.status).to eql(type.to_s)
      end
    end
  end

  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "has many album categories" do
      assc = described_class.reflect_on_association(:album_categories)
      expect(assc.macro).to eq :has_many
    end

    it "has many albums" do
      assc = described_class.reflect_on_association(:albums)
      expect(assc.macro).to eq :has_many
    end
  end
end
