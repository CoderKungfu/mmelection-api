class API::IncidentsController < ApplicationController
  def index
    @current_page = params[:page] || 1
    @incidents = incidents.order(order_by).page(@current_page)
    @total_records = @incidents.total_count
  end

  def create
    @response_code = 200
    @response_message = 'OK'

    begin
      new_incident_params = incident_params
      new_incident_params['fraud_category'] = FraudCategory.find_by(code: new_incident_params['fraud_category'])
      new_incident_params['photo'] = fetch_photo(new_incident_params['photo']) if new_incident_params['photo']
      Incident.create!(new_incident_params)
    rescue => e
      @response_code = 400
      @response_message = e.message
    end
  end

  private

  def incidents
    query = {}

    if params[:fraud_category]
      fraud_category = FraudCategory.find_by(code: params[:fraud_category])
      query[:fraud_category] = fraud_category
    end

    query[:device_id] = params[:device_id] if params[:device_id]

    Incident.where(query)
  end

  def order_by
    if params[:sort_by] == 'popular'
      'view_count DESC'
    else
      'created_at DESC'
    end
  end

  def incident_params
    json_post = JSON.parse(request.raw_post, symbolize_names: true)
    params.merge!(json_post)
    params.permit(:fraud_category, :state, :region, :township, :description, :reported_time, :photo, :reporter_name, :reporter_contact, :device_id, :font_type)
  end

  def fetch_photo(file_string)
    file = Tempfile.new(['mmelection_incident','.png'], encoding: 'ascii-8bit')
    file.write(Base64.decode64(file_string))
    file.close

    file
  end
end
