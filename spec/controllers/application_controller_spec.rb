require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let!(:application) { FactoryGirl.create(:oauth_application, uid: "30") } # OAuth application
  let!(:token)       { FactoryGirl.create(:oauth_access_token, :application => application, :resource_owner_id => user.id) }

  # before do
    # $headers = { Authorization: "bearer " + token.token }
  # end

  it "token" do
    # puts "========#{user.inspect}========="
    $headers = { Authorization: "bearer " + token.token }
    # $header = @header
  end

end
