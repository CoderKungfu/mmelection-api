class Incident < ActiveRecord::Base
  belongs_to :fraud_category

  validates_presence_of :fraud_category, :state, :region, :township, :description, :reported_time, :device_id
end
