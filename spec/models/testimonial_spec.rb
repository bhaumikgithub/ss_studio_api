require 'rails_helper'

RSpec.describe Testimonial, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "Associations" do
    it "belongs to contact" do
      assc = described_class.reflect_on_association(:contact)
      expect(assc.macro).to eq :belongs_to
    end

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
