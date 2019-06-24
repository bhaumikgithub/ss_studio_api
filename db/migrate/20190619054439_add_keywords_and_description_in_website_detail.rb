class AddKeywordsAndDescriptionInWebsiteDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :website_details, :meta_keywords, :string
    add_column :website_details, :meta_description, :string
  end
end
