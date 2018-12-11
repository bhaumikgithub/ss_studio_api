class Albums::SingleAlbumAttributesSerializer < ActiveModel::Serializer
  attributes :id, :album_name, :is_private, :status, :updated_at, :created_at, :delivery_status, :portfolio_visibility, :passcode, :status, :photo_count, :selected_photo_count, :recipients_count, :cover_photo, :photo_pagination, :commented_photo_count, :can_moderate_album, :user_name, :show_album_url, :album_view_count, :user_view_count
  has_many :photos, key: "photos", serializer: Albums::PhotoAttributesSerializer
  has_many :categories, key: "categories",serializer: Albums::SingleCategoriesAttributesSerializer
  has_many :album_recipients, key: "album_recipients", serializer: AlbumRecipients::AdminAlbumRecipientsAttributesSerializer

  def photo_count
    object.photos.count
  end

  def selected_photo_count
    object.photos.where('is_selected = true').count
  end

  def recipients_count
    object.album_recipients.where("recipient_type=(?)",0).count
  end

  def user_name
    object&.user&.alias
  end

  def photos
    object.photos.order(
      'created_at DESC'
    ).page(
      instance_options[:params][:page]
    ).per(
      instance_options[:params][:per_page]
    )
  end

  def photo_pagination
    meta_attributes(photos)
  end

  def meta_attributes(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

  def cover_photo
    photo = object.photos.where(is_cover_photo: true).first
    if photo.present?
      {
        id: photo.id,
        image_file_name: photo.image_file_name,
        image: CommonSerializer.full_image_url(photo.image.url(:thumb)),
        original_image: CommonSerializer.full_image_url(photo.image.url),
        is_cover_photo: true
      }
    else
      {
        image_file_name: "No image available",
        image: CommonSerializer.full_image_url("/shared_photos/missing.png"),
        is_cover_photo: false
      }
    end
  end

  def updated_at
    CommonSerializer.date_formate(object.updated_at)
  end

  def created_at
    CommonSerializer.date_formate(object.created_at)
  end

  def album_recipients
    object.album_recipients.where("recipient_type=(?)",1)
  end

  def commented_photo_count
    object.photos.joins(:comment).count
  end

  def can_moderate_album
    if instance_options[:params][:token].present? && instance_options[:params][:token] != "null"
      @recipient = Contact.find_by(token: instance_options[:params][:token]).album_recipients.where("recipient_type = (?)",1)
      return @recipient.present? ? true : false
    else
      return false
    end
  end

  def show_album_url
    ENV['FRONT_URL'] + object.user.alias + "/shared_album/" + object.slug
  end

  def album_view_count
    object.album_ip_details.pluck(:count).sum.to_s
  end

  def user_view_count
    object.album_ip_details.pluck(:user_id).count.to_s
  end
end