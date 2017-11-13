class CommonService < BaseService
  attr_accessor :request
  def initialize(request)
    @request = request 
  end

  def call
    is_mobile_device?
  end

  private

  def is_mobile_device? # has to be in here because it has access to "request"
      request.user_agent =~ /\b(Android|iPhone|iPad|Windows Phone)\b/i
   end
end