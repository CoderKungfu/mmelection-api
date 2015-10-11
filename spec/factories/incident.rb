FactoryGirl.define do
  factory :incident do
    fraud_category { FraudCategory.first }
    state Faker::Address.state
    region Faker::Address.state
    township Faker::Address.city
    description Faker::Lorem.paragraph(2)
    device_id Faker::Internet.mac_address
  end
end
