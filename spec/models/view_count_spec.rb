require 'rails_helper'

RSpec.describe ViewCount, type: :model do
  describe 'associations' do
    it { should belong_to :item }
  end
end
