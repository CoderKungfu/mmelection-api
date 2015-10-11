class API::IncidentsController < ApplicationController
  def index
    @current_page = params[:page] || 1
    @incidents = Incident.page(@current_page)
    @total_records = @incidents.count
  end

  def create
    @response_code = 200
    @response_message = 'OK'

    begin
      new_incident_params = incident_params
      new_incident_params['fraud_category'] = FraudCategory.find_by(code: incident_params['fraud_category'])
      Incident.create!(new_incident_params)
    rescue => e
      @response_code = 400
      @response_message = e.message
    end
  end

  def incident_params
    json_post = JSON.parse(request.raw_post, symbolize_names: true)
    params.merge!(json_post)
    params.permit(:fraud_category, :state, :region, :township, :description, :reported_time, :photo, :reporter_name, :reporter_contact, :device_id)
  end
end
