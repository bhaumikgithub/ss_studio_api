class WidgetsController < ApplicationController
  
  before_action :fetch_home_widget, only: [ :home_widget, :portfolio_widget, :film_widget, :testimonial_widget, :service_widget, :about_us_widget, :contact_us_widget ]
  before_action :fetch_widget, only: [ :update ]

  def index
  end

  def home_widget
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create!(widget_type: "home")
    end
  	render_success_response({ :home_widget => @widget}, 200)
  end

  def update
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create(resource_params)
    else
      @widget.update_attributes!(resource_params)
    end
  	render_success_response({ :widget => @widget}, 200)
  end

  def portfolio_widget
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create!(widget_type: "portfolio")
    end
  	render_success_response({ :portfolio_widget => @widget}, 200)
  end

  def film_widget
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create!(widget_type: "film")
    end
  	render_success_response({ :film_widget => @widget}, 200)
  end

  def service_widget
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create!(widget_type: "service")
    end
  	render_success_response({ :service_widget => @widget}, 200)
  end

  def testimonial_widget
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create!(widget_type: "testimonial")
    end
  	render_success_response({ :testimonial_widget => @widget}, 200)
  end

  def about_us_widget
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create!(widget_type: "about_us")
    end
  	render_success_response({ :about_us_widget => @widget}, 200)
  end

  def contact_us_widget
  	unless @widget.present?
      @widget = current_resource_owner.widgets.create!(widget_type: "contact_us")
    end
  	render_success_response({ :contact_us_widget => @widget}, 200)
  end

  private

  def resource_params
    params.require(:widget).permit(:title, :code, :widget_type, :is_active)
  end

  def fetch_home_widget
    @widget = current_resource_owner.widgets.where(widget_type: params[:widget_type]).first if current_resource_owner.widgets.present?
  end

  def fetch_widget
  	@widget = Widget.find(params[:id])
  end
end
