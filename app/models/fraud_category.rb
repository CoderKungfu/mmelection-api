class FraudCategory < ActiveRecord::Base
  has_many :incidents
end
