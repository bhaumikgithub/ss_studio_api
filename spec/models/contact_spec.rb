require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.create(:contact, user: user) }

  it 'success' do
    expect(contact).to be_valid
  end

  context 'Validate Album' do
    it 'should validate email presence' do
      contact.email = ' '
      contact.valid?
      expect(contact.errors[:email]).to include("can't be blank", "is invalid")
    end

    it 'should validate phone presence' do
      contact.phone = ' '
      contact.valid?
      expect(contact.errors[:phone]).to include("is too short (minimum is 10 characters)")
    end

    it 'should validate phone length' do
      contact.phone = '9999999999999'
      contact.valid?
      expect(contact[:phone].length).to be_between(10, 13).inclusive
    end

    it 'should validate email format' do
      contact.email = 'aa@g.com'
      contact.valid?
      expect(contact[:email]).to match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
    end
  end

  describe 'email uniqueness' do
    before { FactoryGirl.create :contact, email: 'foo@bar.com' }
    let(:contact) { FactoryGirl.build :contact, email: 'foo@bar.com' }
    it 'must be unique' do
      contact.valid?
      expect(contact.errors[:email]).to be == ['has already been taken']
    end
  end

  # describe 'phone uniqueness' do
  #   before { FactoryGirl.create :contact, phone: '9698969896' }
  #   let(:contact) { FactoryGirl.build :contact, phone: '9698969896' }
  #   it 'must be unique' do
  #     contact.valid?
  #     expect(contact.errors[:phone]).to be == ['has already been taken']
  #   end
  # end

  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end

  context "when created" do
    it "should have 10 digits token" do
      expect(contact.token.length).to be(10)
    end

    it "should have generate_token method" do
      expect(contact.generate_token).to be(true)
    end
  end
end
