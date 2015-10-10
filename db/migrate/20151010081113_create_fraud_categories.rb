class CreateFraudCategories < ActiveRecord::Migration
  def change
    create_table :fraud_categories do |t|
      t.string :code
      t.string :description

      t.timestamps null: false
    end
  end
end
