class AddRatingToTestimonials < ActiveRecord::Migration[5.0]
  def change
    add_column :testimonials, :rating, :integer
  end
end
