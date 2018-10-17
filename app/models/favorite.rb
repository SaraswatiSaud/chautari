# frozen_string_literal: true

# Favorite class
class Favorite < ApplicationRecord
  belongs_to :station
  belongs_to :user
end
