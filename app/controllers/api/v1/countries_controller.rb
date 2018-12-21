# frozen_string_literal: true

module Api
  module V1
    # Countries API class
    class CountriesController < ApiController
      respond_to :json

      def index
        @countries = Country.all
        # json_response @countries
      end

      def show
        country = Country.friendly.find(params[:id])
        @stations = country.stations.active
      end
    end
  end
end
