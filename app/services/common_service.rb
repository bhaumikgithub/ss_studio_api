class CommonService < BaseService
  class << self
    def is_mobile_devise(request)
      request.user_agent =~ /\b(Android|iPhone|iPad|Windows Phone)\b/i
    end

    def get_contacts(current_user, params = {})
      current_user.contacts.page(
        params[:page]
      ).per(
        params[:per_page]
      ).order(
        "contacts.updated_at #{params[:sorting_order]}"
      )
    end
  end
end