require 'rails_helper'

RSpec.describe API::IncidentsController, type: :controller do

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns correct keys' do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to eq ['count','page','data']
    end

    context 'with incidents' do
      before do
        FactoryGirl.create :incident
        get :index, format: :json
      end

      it 'renders the Jbuilder for incident' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']).to_not be_empty
        expect(json_response['data'].first.keys).to eq ['incident_id','fraud_category','state','region','township','description','reported_time','photo','view_count']
      end
    end
  end

  describe 'POST #create' do
    let(:fraud_category) { 'type_1' }
    let(:state) { 'Lower Myanmar' } # Lower Myanmar
    let(:region) { 'Yangon Region' } # Yangon Region
    let(:township) { 'Yangon' } # Yangon
    let(:description) { 'some description' }
    let(:reported_time) { '2015-10-11 10:10:00 +06:30' }
    let(:photo) { nil }
    let(:reporter_name) { 'Ei Wai' }
    let(:reporter_contact) { 'contact@example.com' }
    let(:device_id) { 'device1' }

    let(:incident_params) do
      {
        fraud_category: fraud_category,
        state: state,
        region: region,
        township: township,
        description: description,
        reported_time: reported_time,
        photo: photo,
        reporter_name: reporter_name,
        reporter_contact: reporter_contact,
        device_id: device_id
      }
    end

    let(:json) { json_response = JSON.parse(response.body) }

    before do
      post :create, incident_params.to_json, format: :json
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'saves new incident' do
      expect(json['response_message']).to eq 'OK'
      expect(Incident.count).to eq 1
    end
  end
end
