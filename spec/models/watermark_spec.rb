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
end
