# frozen_string_literal: true

# Validation Error Serializer
class ValidationErrorSerializer
  def initialize(record, field, detail)
    @record = record
    @field = field
    @detail = detail
  end

  def serialize
    {
      resource: resource,
      field: field,
      detail: detail
    }
  end

  private

  def resource
    I18n.t(
      underscored_resource_name,
      scope: [:resources],
      default: @record.class.to_s
    )
  end

  def field
    I18n.t(
      @field,
      scope: [:fields, underscored_resource_name],
      default: @field.to_s
    )
  end

  def detail
    I18n.t(
      @detail,
      scope: [:details],
      default: @detail.to_s
    )
  end

  def underscored_resource_name
    @record.class.to_s.gsub('::', '').underscore
  end
end
