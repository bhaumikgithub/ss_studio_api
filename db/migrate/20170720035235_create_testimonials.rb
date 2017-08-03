class CreateTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :testimonials do |t|
      t.string :client_name
      t.references :contact, foreign_key: true
      t.text :message
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
