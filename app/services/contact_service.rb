class ContactService < BaseService
  attr_accessor :current_user, :params
  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params
  end

  def call
    display_contacts
  end

  private

  def display_contacts
    contacts = contact_with_pagination(current_user_contact)
    return_hash(contacts)
  end

  def current_user_contact
    current_user.contacts.order(
      "contacts.updated_at #{params[:sorting_order]}"
    )
  end

  def contact_with_pagination(contacts)
    contacts.page(
      params[:page]
    ).per(
      params[:per_page]
    )
  end

  def return_hash(contacts)
    {
      data: {
        contacts: ActiveModel::Serializer::CollectionSerializer.new(contacts, serializer: Contacts::ContactAttributesSerializer, style: "thumb")
      },
      contacts: contacts
    }
  end
end