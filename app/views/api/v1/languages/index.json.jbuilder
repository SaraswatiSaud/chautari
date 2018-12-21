# frozen_string_literal: true

json.array! @languages.limit(10), partial: 'language', as: :language
