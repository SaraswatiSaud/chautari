# frozen_string_literal: true

module Api
  module V1
    # Countries API class
    class StationsController < ApiController
      respond_to :json

      def index
        @stations = Station.order(id: :desc).page params[:page]
      end

      def show
        @station = Station.find params[:id]
      end
    end
  end
end
