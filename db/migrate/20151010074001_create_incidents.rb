class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.integer :fraud_category_id, index: true
      t.string :state
      t.string :region
      t.string :township
      t.text :description
      t.datetime :reported_time
      t.string :photo, null: true, default: nil
      t.string :reporter_name, null: true, default: nil
      t.string :reporter_contact, null: true, default: nil
      t.string :device_id, index: true
      t.integer :view_count, default: 0

      t.timestamps null: false
    end
  end
end
