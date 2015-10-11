json.incident_id incident.id
json.fraud_category incident.fraud_category.code
json.state incident.state
json.region incident.region
json.township incident.township
json.description incident.description
json.reported_time incident.reported_time.to_time.strftime('%Y-%m-%d %T %z')
json.photo incident.photo.url
json.view_count incident.view_count
