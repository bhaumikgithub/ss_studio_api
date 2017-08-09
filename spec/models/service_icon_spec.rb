require 'rails_helper'

RSpec.describe ServiceIcon, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "Associations" do
    it "has many services" do
      assc = described_class.reflect_on_association(:services)
      expect(assc.macro).to eq :has_many
    end
  end

  describe 'Service' do
    let(:status) do
      { inactive: 0,
        active: 1
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
end
