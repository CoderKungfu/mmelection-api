json.count @total_records
json.page @current_page
json.data @incidents, partial: 'api/incidents/incident', as: :incident
