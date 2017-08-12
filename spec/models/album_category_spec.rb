require 'rails_helper'

RSpec.describe AlbumCategory, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "Associations" do
    it "belongs to album" do
      assc = described_class.reflect_on_association(:album)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to category" do
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
