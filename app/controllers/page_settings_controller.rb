class PageSettingsController < ApplicationController
  before_action :fetch_page, only: [ :home_page, :film_page, :service_page, :testimonial_page, :about_us_page, :contact_us_page ]
  before_action :find_page, only: [ :update ]

  def index
  end

  def update
  	unless @page_setting.present?
      @page_setting = current_resource_owner.page_settings.create(resource_params)
    else
      @page_setting.update_attributes!(resource_params)
    end
  	render_success_response({ :page_setting => @page_setting}, 200)
  end

  def home_page
  	unless @page_setting.present?
      @page_setting = current_resource_owner.page_settings.create!(page_type: "home")
    end
  	render_success_response({ :home_page => @page_setting}, 200)
  end

  def film_page
  	unless @page_setting.present?
      @page_setting = current_resource_owner.page_settings.create!(page_type: "film")
    end
  	render_success_response({ :film_page => @page_setting}, 200)
  end

  def service_page
  	unless @page_setting.present?
      @page_setting = current_resource_owner.page_settings.create!(page_type: "service")
    end
  	render_success_response({ :service_page => @page_setting}, 200)
  end

  def testimonial_page
  	unless @page_setting.present?
      @page_setting = current_resource_owner.page_settings.create!(page_type: "testimonial")
    end
  	render_success_response({ :testimonial_page => @page_setting}, 200)
  end

  def about_us_page
  	unless @page_setting.present?
      @page_setting = current_resource_owner.page_settings.create!(page_type: "about_us")
    end
  	render_success_response({ :about_us_page => @page_setting}, 200)
  end

  def contact_us_page
  	unless @page_setting.present?
      @page_setting = current_resource_owner.page_settings.create!(page_type: "contact_us")
    end
  	render_success_response({ :contact_us_page => @page_setting}, 200)
  end

  private

  def resource_params
    params.require(:page_setting).permit(:is_show, :page_type)
  end

  def fetch_page
    @page_setting = current_resource_owner.page_settings.where(page_type: params[:page_type]).first if current_resource_owner.page_settings.present?
  end

  def find_page
  	@page_setting = PageSetting.find(params[:id])
  end
end
