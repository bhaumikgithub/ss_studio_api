require 'rails_helper'

RSpec.describe ContactDetail, type: :model do
  let(:contact_detail) { FactoryGirl.create(:contact_detail) }
  
  context 'Success' do
    let!(:contact_detail) { FactoryGirl.create(:contact_detail, email: 'hello@gmail.com', phone: '9639639639') }
    it 'contact_detail address should be valid' do
      expect(contact_detail).to be_valid
    end
  end

  describe 'email uniqueness' do
    before { FactoryGirl.create :contact_detail, email: 'foo@bar.com' }
    let(:contact_detail) { FactoryGirl.build :contact_detail, email: 'foo@bar.com' }
    it 'must be unique' do
      contact_detail.valid?
      expect(contact_detail.errors[:email]).to be == ['has already been taken']
    end
  end

  describe 'phone uniqueness' do
    before { FactoryGirl.create :contact_detail, phone: '9698969896' }
    let(:contact_detail) { FactoryGirl.build :contact_detail, phone: '9698969896' }
    it 'must be unique' do
      contact_detail.valid?
      expect(contact_detail.errors[:phone]).to be == ['has already been taken']
    end
  end

  describe "phone can't be blank"  do
    # before { FactoryGirl.create :contact_detail, phone: '9698969896' }
    let(:contact_detail) { FactoryGirl.build :contact_detail, phone: ' ' }
    it 'must be enter' do
      contact_detail.valid?
      expect(contact_detail.errors[:phone]).to be == ["can't be blank", "is not a number", "is too short (minimum is 10 characters)"]
    end
  end

  context 'Validate Contact Detail' do
    # let(:contact_detail) { FactoryGirl.create(:contact_detail, phone: '9639639639') }
    it 'should validate email' do
      contact_detail.email = ' ' # invalid state
      contact_detail.valid? # run validations
      expect(contact_detail.errors[:email]).to include("can't be blank", "is invalid")
    end

    it 'should validate phone length' do
      contact_detail.phone = '9999999999999'
      contact_detail.valid?
      expect(contact_detail[:phone].length).to be_between(10, 13).inclusive
    end

    it 'should validate phone must be numeric and minimum range must be 10 characters' do
      contact_detail.phone = 'aa' # invalid state
      contact_detail.valid? # run validations
      expect(contact_detail.errors[:phone]).to include("is not a number", "is too short (minimum is 10 characters)")
    end

    it 'should validate phone must be numeric and maximum range 13 characters' do
      contact_detail.phone = 'qqqqqqqqqqqqqq' # invalid state
      contact_detail.valid? # run validations
      expect(contact_detail.errors[:phone]).to include("is not a number", "is too long (maximum is 13 characters)")
    end

    it 'should validate numeric minimum range' do
      contact_detail.phone = '969696969' # invalid state
      contact_detail.valid? # run validations
      expect(contact_detail.errors[:phone]).to include("is too short (minimum is 10 characters)")
    end

    it 'should validate numeric maximum range' do
      contact_detail.phone = '96969696969696' # invalid state
      contact_detail.valid? # run validations
      expect(contact_detail.errors[:phone]).to include("is too long (maximum is 13 characters)")
    end

    it 'should validate email format' do
      contact_detail.email = 'test@gmail.com'
      contact_detail.valid?
      expect(contact_detail[:email]).to match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
    end
  end

  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
