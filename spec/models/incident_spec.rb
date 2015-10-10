require 'rails_helper'

RSpec.describe Incident, type: :model do
  describe 'associations' do
    it { should belong_to :fraud_category }
  end

  describe 'validations' do
    it { should validate_presence_of :fraud_category }
    it { should validate_presence_of :state }
    it { should validate_presence_of :region }
    it { should validate_presence_of :township }
    it { should validate_presence_of :description }
    it { should validate_presence_of :reported_time }
    it { should validate_presence_of :device_id }
  end
end
