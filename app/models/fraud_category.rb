class FraudCategory < ActiveRecord::Base
  has_many :incidents

  def name
    "#{description} (#{code})"
  end
end
