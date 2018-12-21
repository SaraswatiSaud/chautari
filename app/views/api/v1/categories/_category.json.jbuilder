# frozen_string_literal: true

json.extract! category, :id, :title, :description, :ancestry
json.url category_url(category, format: :json)
