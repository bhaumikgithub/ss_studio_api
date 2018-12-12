class Users::UserPackagesAttributeSerializer < ActiveModel::Serializer
  attributes :id, :plan, :package_start_date, :package_end_date, :amount, :package_status, :transaction_date

  def plan
    object.package.name
  end

  def package_start_date
    object.package_start_date.strftime("%d %b %Y") if object.package_start_date.present?
  end

  def package_end_date
    object.package_end_date.strftime("%d %b %Y") if object.package_end_date.present?
  end

  def amount
    object.package.price.to_i
  end
end