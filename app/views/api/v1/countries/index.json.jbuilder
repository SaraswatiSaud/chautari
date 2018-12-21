# frozen_string_literal: true

json.array! @countries.limit(10), partial: 'country', as: :country
