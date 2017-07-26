require 'rails_helper'

RSpec.describe Service, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:service_icon) { FactoryGirl.create(:service_icon) }
  let(:service) { FactoryGirl.create(:service, service_icon_id: service_icon) }

  it 'success' do
    expect(service).to be_valid
  end

  context 'Validate Album' do
    it 'should validate service name presence' do
      service.service_name = ' '
      service.valid?
      expect(service.errors[:service_name]).to include("can't be blank")
    end

    it 'should validate description length' do
      service.description = 'testing testing testing service'
      service.valid?
      expect(service[:description].length).to be_between(30, 150).inclusive
    end
  end

  describe 'service name uniqueness' do
    before { FactoryGirl.create :service, service_name: 'portfolio' }
    let(:service) { FactoryGirl.build :service, service_name: 'portfolio' }
    it 'must be unique' do
      service.valid?
      expect(service.errors[:service_name]).to be == ['has already been taken']
    end
  end

  context "Associations" do
    it "belongs to service_icon" do
      assc = described_class.reflect_on_association(:service_icon)
      expect(assc.macro).to eq :belongs_to
    end
  end

end
