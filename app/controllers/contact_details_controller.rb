class ContactDetailsController < ApplicationController
  include InheritAction
  skip_before_action :doorkeeper_authorize!
end
