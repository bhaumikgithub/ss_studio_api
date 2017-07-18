require 'rails_helper'

RSpec.describe Album, type: :model do
  subject { described_class.new }
  before do
    FactoryGirl.create(:album, album_name: 'album 123')
  end

  let(:album) { FactoryGirl.create(:album) }
  context 'Success' do
    let!(:album1) { FactoryGirl.create(:album, album_name: 'album 1') }
    it 'orders by album name' do
      expect(album1).to be_valid
    end
  end

  context 'Validate Category' do
    it 'should validate presence' do
      album.album_name = '' # invalid state
      album.valid? # run validations
      expect(album.errors[:album_name]).to include("can't be blank")
    end

    it 'should validate minimum range' do
      album.album_name = 'aa' # invalid state
      album.valid? # run validations
      expect(album.errors[:album_name]).to include("is too short (minimum is 3 characters)")
    end

    it 'should validate maximum range' do
      album.album_name = 'album1 and album2 marriage anniversary' # invalid state
      album.valid? # run validations
      expect(album.errors[:album_name]).to include("is too long (maximum is 30 characters)")
    end

    it "is not valid without a album name" do
      expect(subject).to_not be_valid
    end

    it "should have a unique name" do
      album.album_name = 'album 123'
      album.valid?
      expect(album.errors[:album_name]).to include("has already been taken")
    end
  end

  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "has many album_categories" do
      assc = described_class.reflect_on_association(:album_categories)
      expect(assc.macro).to eq :has_many
    end

    it "has many categories" do
      assc = described_class.reflect_on_association(:categories)
      expect(assc.macro).to eq :has_many
    end

    it "has many photos" do
      assc = described_class.reflect_on_association(:photos)
      expect(assc.macro).to eq :has_many
    end
  end
end
