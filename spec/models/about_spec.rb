require 'rails_helper'

RSpec.describe About, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:about) { FactoryGirl.create(:about) }
  
  context 'Success' do
    let(:photo) { FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user_id: user.id) }
    let(:about1) { FactoryGirl.create(:about, photo: photo) }

    it 'orders by about details' do
      expect(about).to be_valid
    end

    it 'nested attribute for photo' do
      expect(about1).to be_valid
    end
  end

  context "Associations" do
    it "has one to photo" do
      assc = described_class.reflect_on_association(:photo)
      expect(assc.macro).to eq :has_one
    end
  end
end
  