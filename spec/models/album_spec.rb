require 'rails_helper'

RSpec.describe Album, type: :model do
  # subject { described_class.new }
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

  context 'Validate Album' do
    it 'should validate presence' do
      album.album_name = '' # invalid state
      album.valid? # run validations
      expect(album.errors[:album_name]).to include("can't be blank")
    end

    it 'should validate album name range' do
      album.album_name = 'aaa' # invalid state
      album.valid? # run validations
      expect(album[:album_name].length).to be_between(3, 30).inclusive
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

  describe 'album name uniqueness' do
    before { FactoryGirl.create :album, album_name: 'test' }
    let(:album) { FactoryGirl.build :album, album_name: 'test' }
    it 'must be unique' do
      album.valid?
      expect(album.errors[:album_name]).to be == ['has already been taken']
    end
  end

  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "has many album categories" do
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

    it "has many album recipients" do
      assc = described_class.reflect_on_association(:album_recipients)
      expect(assc.macro).to eq :has_many
    end
  end

  describe 'Album' do
    let(:status) do {
      inactive: 0, active: 1
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

    let(:delivery_status) do {
      New: 0 , Shared: 1, Submitted: 2, Delivered: 3
      }
    end

    it 'has valid a delivery status' do
      delivery_status.each do |type, value|
        subject.delivery_status = value
        subject.save
        expect(subject.delivery_status).to eql(type.to_s)
      end
    end
  end

  context "when created" do
    it "should have 8 digits token" do
      expect(album.passcode.length).to be(8)
    end

    it "should have generate_passcode method" do
      expect(album.generate_passcode).to be(true)
    end
  end
end
