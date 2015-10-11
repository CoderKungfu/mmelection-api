class API::IncidentsController < ApplicationController
  def index
    @current_page = params[:page] || 1
    @incidents = incidents.order(order_by).page(@current_page)
    @total_records = @incidents.count
  end

  def create
    @response_code = 200
    @response_message = 'OK'

    begin
      new_incident_params = incident_params
      new_incident_params['fraud_category'] = FraudCategory.find_by(code: incident_params['fraud_category'])
      new_incident_params['photo'] = fetch_photo(incident_params['photo'])
      Incident.create!(new_incident_params)
    rescue => e
      @response_code = 400
      @response_message = e.message
    end
  end

  private

  def incidents
    if params[:fraud_category]
      fraud_category = FraudCategory.find_by(code: params[:fraud_category])
      Incident.where(fraud_category: fraud_category)
    else
      Incident
    end
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
    params.permit(:fraud_category, :state, :region, :township, :description, :reported_time, :photo, :reporter_name, :reporter_contact, :device_id)
  end

  def fetch_photo(file_string)
    file = Tempfile.new(['mmelection_incident','.png'], encoding: 'ascii-8bit')
    file.write(Base64.decode64(file_string))
    file.close

    file
  end
end
