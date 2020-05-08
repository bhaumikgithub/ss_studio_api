class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :title, :code, :widget_type, :is_active
end
