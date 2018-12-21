# frozen_string_literal: true

module Api
  module V1
    # Languages API class
    class LanguagesController < ApiController
      respond_to :json

      def index
        @languages = Language.all
      end

      def show
        language = Language.friendly.find(params[:id])
        @stations = language.stations.active
      end
    end
  end
end
