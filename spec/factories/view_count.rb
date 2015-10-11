FactoryGirl.define do
  factory :view_count do
    incident
    device_id Faker::Internet.mac_address
  end
end
