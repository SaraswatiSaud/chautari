# frozen_string_literal: true

# Add favorite button
module Favoritable
  include ActiveSupport::Concern

  def favorites_button(station)
    @favorites_button =
      if user_signed_in? && current_user.favorite?(station)
        favorite = current_user.favorite(station)
        { link: station_favorite_path(station, favorite), method: :delete }
      else
        { link: station_favorites_path(station), method: :post }
      end
  end
end
