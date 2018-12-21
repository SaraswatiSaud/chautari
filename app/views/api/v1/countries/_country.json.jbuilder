# frozen_string_literal: true

json.extract! country, :id, :name, :iso_code, :slug
json.url country_url(country, format: :json)
