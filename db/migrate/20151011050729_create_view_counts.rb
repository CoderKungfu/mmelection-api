class CreateViewCounts < ActiveRecord::Migration
  def change
    create_table :view_counts do |t|
      t.references :item, index: true, polymorphic: true
      t.string :device_id, index: true

      t.timestamps null: false
    end
    add_index(:view_counts, [:item_type, :item_id, :device_id], name: 'by_viewer')
  end
end
