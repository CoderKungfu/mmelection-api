require 'rails_helper'

RSpec.describe Incident, type: :model do
  describe 'associations' do
    it { should belong_to :fraud_category }
    it { should have_many :view_counts }
  end

  describe 'validations' do
    it { should validate_presence_of :fraud_category }
    it { should validate_presence_of :state }
    it { should validate_presence_of :region }
    it { should validate_presence_of :township }
    it { should validate_presence_of :description }
    it { should validate_presence_of :device_id }
  end

  describe 'before_create' do
    it 'sets reported_time' do
      incident = FactoryGirl.build :incident
      incident.save

      expect(incident.reported_time).to_not be_nil
    end
  end
end
