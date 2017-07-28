require 'rails_helper'

RSpec.describe AlbumRecipient, type: :model do
  context "Associations" do
    it "belongs to album" do
      assc = described_class.reflect_on_association(:album)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to contact" do
      assc = described_class.reflect_on_association(:contact)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
