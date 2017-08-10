# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { FactoryGirl.create(:user) }

  context "Associations" do
    it "has many contacts" do
      assc = described_class.reflect_on_association(:contacts)
      expect(assc.macro).to eq :has_many
    end

    it "has many category" do
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :has_many
    end

    it "has many watermarks" do
      assc = described_class.reflect_on_association(:watermarks)
      expect(assc.macro).to eq :has_many
    end

    it "has many albums" do
      assc = described_class.reflect_on_association(:albums)
      expect(assc.macro).to eq :has_many
    end

    it "has many photos" do
      assc = described_class.reflect_on_association(:photos)
      expect(assc.macro).to eq :has_many
    end

    it "has many contact_details" do
      assc = described_class.reflect_on_association(:contact_details)
      expect(assc.macro).to eq :has_many
    end

    it "has many videos" do
      assc = described_class.reflect_on_association(:videos)
      expect(assc.macro).to eq :has_many
    end

    it "has many homepage_photos" do
      assc = described_class.reflect_on_association(:homepage_photos)
      expect(assc.macro).to eq :has_many
    end

    it "has many testimonials" do
      assc = described_class.reflect_on_association(:testimonials)
      expect(assc.macro).to eq :has_many
    end
  end

  describe 'User' do
    let(:status) do
      { inactive: 0,
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

  context "when created" do
    it "should have full_name method" do
      expect(user.full_name.present?).to be(true)
    end
  end
end
