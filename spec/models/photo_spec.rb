require 'rails_helper'

RSpec.describe Photo, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { FactoryGirl.create (:user) }
  let(:album) { FactoryGirl.create(:album, user: user) }
  let(:photo) { FactoryGirl.create(:photo, image: File.new(Rails.root + 'public/watermark.png'), user: user, imageable_id: album.id, imageable_type: 'Album') }

  # before do
  #   @user = FactoryGirl.create (:user)
  #   @album = FactoryGirl.create(:album, user: @user)
  #   @photo = FactoryGirl.create(:photo, user: @user)
  # end

  context "Associations" do
    it "belongs to imageable" do
      assc = described_class.reflect_on_association(:imageable)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to watermark" do
      assc = described_class.reflect_on_association(:watermark)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "has many to homepage photos" do
      assc = described_class.reflect_on_association(:homepage_photos)
      expect(assc.macro).to eq :has_many
    end
  end

  it 'get the content type from photo' do
    expect(photo[:image_content_type]).to eq("image/jpeg").or eq("image/png").or eq("image/jpg").or eq("image/gif")
  end

  context "when created" do
    it "should have imageable type" do
      expect(photo.imageable_type).to eq("Album")
    end

    it "should have photo_name method" do
      expect(photo.photo_name).to be(true)
    end

    it "should have set_as_cover method" do
      expect(photo.set_as_cover).to be(true)
    end

    it "should have update_user method" do
      expect(photo.update_user(user)).to be(true)
    end
  end

  describe 'Photo' do
    let(:status_values) do
      { inactive: 0,
        active: 1
        # etc
      }
    end
    subject { described_class.new }

    it 'has valid a status' do
      status_values.each do |type, value|
        subject.status = value
        subject.save
        expect(subject.status).to eql(type.to_s)
      end
    end
  end

end
