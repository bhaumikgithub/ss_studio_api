class Users::ConfirmationsController < Devise::ConfirmationsController
	skip_before_action :doorkeeper_authorize!
end
