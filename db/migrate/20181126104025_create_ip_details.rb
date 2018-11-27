class CreateIpDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :ip_details do |t|
      t.string :ip_address

      t.timestamps
    end
  end
end
