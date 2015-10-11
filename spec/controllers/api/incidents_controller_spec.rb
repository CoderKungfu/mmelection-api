require 'rails_helper'

RSpec.describe API::IncidentsController, type: :controller do

  describe 'GET #index' do
    let(:json) { json_response = JSON.parse(response.body) }

    context 'with correct request' do
      before do
        get :index, format: :json
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns correct keys' do
        expect(json.keys).to eq ['count','page','data']
      end

      context 'with incidents' do
        before do
          FactoryGirl.create :incident
          get :index, format: :json
        end

        it 'renders the Jbuilder for incident' do
          expect(json['data']).to_not be_empty
          expect(json['data'].first.keys).to eq ['incident_id','fraud_category','state','region','township','description','reported_time','photo','view_count']
        end
      end
    end

    context 'by category' do
      let!(:type_1_incident) { FactoryGirl.create :incident, fraud_category_id: 1 }
      let!(:type_2_incident) { FactoryGirl.create :incident, fraud_category_id: 2 }

      before do
        get :index, format: :json, fraud_category: 'type_1'
      end

      describe 'with the category param' do
        it 'filters by category' do
          expect(json['data'].count).to eq 1
          expect(json['data'].first['incident_id']).to eq type_1_incident.id
          expect(json['data'].first['fraud_category']).to eq 'type_1'
        end
      end
    end

    context 'sort by latest' do
      let!(:later_incident) { FactoryGirl.create :incident, created_at: 2.days.ago }
      let!(:recent_incident) { FactoryGirl.create :incident, created_at: 1.day.ago }

      before do
        get :index, format: :json
      end

      describe 'without any sort order' do
        it 'sort by latest' do
          expect(json['data'].first['incident_id']).to eq recent_incident.id
          expect(json['data'].second['incident_id']).to eq later_incident.id
        end
      end
    end

    context 'sort by popular' do
      let!(:normal_incident) { FactoryGirl.create :incident, view_count: 1 }
      let!(:popular_incident) { FactoryGirl.create :incident, view_count: 10 }

      before do
        get :index, format: :json
      end

      describe 'without any sort order' do
        it 'sort by latest' do
          expect(json['data'].first['incident_id']).to eq popular_incident.id
          expect(json['data'].second['incident_id']).to eq normal_incident.id
        end
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
    let(:image_file) { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'bojio.png')) }
    let(:photo) { Base64.encode64(image_file.read) }

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
