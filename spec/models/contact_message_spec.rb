require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:contact_message) { FactoryGirl.create(:contact_message) }

  context 'Success' do
    it 'data should be valid' do
      puts "===========#{contact_message.inspect}=========="
      expect(contact_message).to be_valid
    end
  end 

  describe 'Validate Presence'  do
    # before { FactoryGirl.create :contact_message, name: 'testing' }
    context "name can't be blank" do
      let(:contact_message) { FactoryGirl.build :contact_message, name: ' ' }
      it 'must be enter' do
        contact_message.valid?
        expect(contact_message.errors[:name]).to be == ["can't be blank"]
      end
    end

    context "phone can't be blank" do
      let(:contact_message) { FactoryGirl.build :contact_message, phone: ' ' }
      it 'must be enter' do
        contact_message.valid?
        expect(contact_message.errors[:phone]).to be == ["can't be blank", "is not a number"]
      end

      it 'must be numeric' do
        contact_message.phone = 'abc'
        contact_message.valid?
        expect(contact_message.errors[:phone]).to be == ["is not a number"]
      end
    end

    context "email can't be blank" do
      let(:contact_message) { FactoryGirl.build :contact_message, email: ' ' }
      it 'must be enter' do
        contact_message.valid?
        expect(contact_message.errors[:email]).to be == ["can't be blank"]
      end
    end
  end
end
