json.extract! station, :id, :name
json.image image_url(station.logo_url)
# json.url station_url(station, format: :json)
json.stream_url station.active_streams.first.try(:url)
