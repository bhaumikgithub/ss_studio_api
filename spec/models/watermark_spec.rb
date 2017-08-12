require 'rails_helper'

RSpec.describe Watermark, type: :model do
  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
    
    it "has one to photo" do
      assc = described_class.reflect_on_association(:photo)
      expect(assc.macro).to eq :has_one
    end
  end

  describe 'Watermark' do
    let(:status) do {
      inactive: 0,
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
