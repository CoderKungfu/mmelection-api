require 'rails_helper'

RSpec.describe FraudCategory, type: :model do
  describe 'associations' do
    it { should have_many(:incidents) }
  end
end
