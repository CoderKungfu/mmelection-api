ActiveAdmin.register Incident do

  actions :all, except: [:new, :edit, :update]
  config.sort_order = 'reported_time_desc'

  filter :state
  filter :region
  filter :township
  filter :fraud_category
  filter :reporter_name
  filter :reporter_contact
  filter :reported_time

  index do
    id_column
    column 'Reported At', :reported_time
    column 'Category', sortable: :fraud_category_id do |incident|
      incident.fraud_category.code
    end
    column :state
    column :region
    column :township
    column 'Photo' do |incident|
      image_tag incident.photo, width: '200px' if incident.photo.present?
    end
    column :reporter_name
    actions
  end

  show do
    attributes_table do
      row 'Reported At' do |incident|
        incident.reported_time
      end
      row 'Category' do |incident|
        incident.fraud_category.name
      end
      row :state
      row :region
      row :township
      row :photo do |incident|
        image_tag incident.photo if incident.photo.present?
      end
      row :description
      row :reporter_name
      row :reporter_contact
    end
  end
end
