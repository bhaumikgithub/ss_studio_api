class BlogsController < ApplicationController

	skip_before_action :doorkeeper_authorize!, only: [ :active_blogs ]
	before_action :fetch_blog, only: [ :update, :show ]

  # GET /blog
  def show
    unless @blog.present?
      @blog = current_resource_owner.create_blog()
    end
    render_success_response({ :blog => @blog}, 200)
  end

	# GET /blogs
  def active_blogs
  	@blog = User.get_user(params[:user]).blog
    if @blog.present? && @blog.is_show
      respond_to do |format|
        format.html
      end
    else
      redirect_to active_homepage_photo_path
    end
    # render_success_response({ :blog => User.get_user(params[:user]).blog}, 200)
  end

	# POST  /blogs
  def create
    @blog = current_resource_owner.create_blog(resource_params)
    render_success_response({ :blog => @blog}, 201) if @blog
  end

  # PATCH /blogs
  def update
    unless @blog.present?
      @blog = current_resource_owner.create_blog(resource_params)
    else
      @blog.update_attributes!(resource_params)
    end
    render_success_response({ :blog => @blog}, 201)
  end

  private

  def resource_params
    params.require(:blog).permit(:is_show, :blog_url)
  end

  def fetch_blog
    @blog = current_resource_owner.blog
  end
end
