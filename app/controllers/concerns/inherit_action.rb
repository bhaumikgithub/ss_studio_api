module InheritAction
  extend ActiveSupport::Concern

  included do
    before_action :get_resource, only: [:show, :edit, :update, :destroy]
  end

  # GET
  def index
    @resources ||= resource_class.all

    render_success_response({ :"#{resource_name_plural}" => @resources })
  end

  # POST
  def create
    @resource ||= resource_class.create!(resource_params)

    render_success_response(@resource, 201)
  end

  # GET
  def show
    render_success_response(@resource)
  end

  # PATCH/PUT
  def update
    @resource.update_attributes!(resource_params)

    render_success_response(@resource, 201)
  end

  # DELETE
  def destroy
    @resource.destroy!

    head 200
  end

  private

  def get_resource
    @resource ||= resource_class.find(params[:id])
  end

  def resource_class
    resource_name.classify.constantize
  end

  def resource_params
    params.fetch(resource_name, {}).permit(permitted_attributes)
  end

  def permitted_attributes
    columns = resource_class.column_names.dup
    return columns.delete_if {|column| ["id","created_at","updated_at", "deleted_at"].include?(column)}
  end

  def resource_name
    controller_name.singularize
  end

  def resource_name_plural
    controller_name
  end
end
