require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video) { FactoryGirl.create(:video) }

  context "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end

  it 'get the content type from photo' do
    expect(video[:video_content_type]).to eq("video/mp4")
  end
end
