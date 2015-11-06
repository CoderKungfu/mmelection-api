class Incident < ActiveRecord::Base
  belongs_to :fraud_category
  has_many :view_counts, as: :item

  validates_presence_of :fraud_category, :state, :region, :township, :description, :device_id, :font_type

  mount_uploader :photo, PhotoUploader

  before_create do
    self.reported_time = Time.now if reported_time.nil?
  end
end
