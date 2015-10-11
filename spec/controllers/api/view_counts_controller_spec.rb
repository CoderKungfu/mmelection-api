require 'rails_helper'

RSpec.describe API::ViewCountsController, type: :controller do
  describe 'POST #create' do
    let(:device_id) { 'device1' }
    let(:incident) { FactoryGirl.create :incident, device_id: device_id }
    let(:view_count_params) do
      {
        device_id: device_id
      }
    end

    before do
      post :create, view_count_params.to_json, format: :json, incident_id: incident
    end

    it 'add to view count' do
      expect(incident.reload.view_count).to eq 1
    end

    context 'multiple post by same device' do
      it 'does not change the view_count' do
        post :create, view_count_params.to_json, format: :json, incident_id: incident
        expect(incident.reload.view_count).to eq 1
      end
    end
  end
end
