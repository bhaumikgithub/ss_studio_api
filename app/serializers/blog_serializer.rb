class BlogSerializer < ActiveModel::Serializer
  attributes :id, :is_show, :blog_url
  has_one :user
end
