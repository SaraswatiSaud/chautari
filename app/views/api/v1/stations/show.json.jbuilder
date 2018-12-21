# frozen_string_literal: true

json.extract! @station, :id, :name
json.image image_url(@station.logo_url)
json.stream_url @station.active_streams.first.try(:url)
