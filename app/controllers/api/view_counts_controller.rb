class API::ViewCountsController < ApplicationController
  def create
    @response_code = 200
    @response_message = 'OK'

    begin
      incident.view_counts.where(device_id: params[:device_id]).first_or_create!
      incident.update(view_count: incident.view_counts.count)
    rescue => e
      @response_code = 400
      @response_message = e.message
    end
  end

  private

  def incident
    Incident.find(params[:incident_id])
  end
end
