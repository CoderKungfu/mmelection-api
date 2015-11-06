class AddFontTypeToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :font_type, :string
  end
end
