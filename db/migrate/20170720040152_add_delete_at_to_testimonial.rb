class AddDeleteAtToTestimonial < ActiveRecord::Migration[5.0]
  def change
    add_column :testimonials, :deleted_at, :datetime
    add_index :testimonials, :deleted_at
  end
end
