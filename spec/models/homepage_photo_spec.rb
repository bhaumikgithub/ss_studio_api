require 'rails_helper'

RSpec.describe HomepagePhoto, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { FactoryGirl.create(:user) }
  let(:photo) {FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user: user)}
  let(:homepage_photo) {FactoryGirl.create(:homepage_photo, photo: photo, user: user, homepage_image: File.new(Rails.root + 'public/watermark.png'))}

  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to photo" do
      assc = described_class.reflect_on_association(:photo)
      expect(assc.macro).to eq :belongs_to
    end
  end

  it 'get the content type from photo' do
    expect(homepage_photo.photo[:image_content_type]).to eq("image/jpeg").or eq("image/png").or eq("image/jpg").or eq("image/gif")
  end

  it 'get content type from homepage_photo' do
    expect(homepage_photo[:homepage_image_content_type]).to eq("image/jpeg").or eq("image/png").or eq("image/jpg").or eq("image/gif")
  end
end
