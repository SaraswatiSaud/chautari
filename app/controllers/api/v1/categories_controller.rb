# frozen_string_literal: true

module Api
  module V1
    # Countries API class
    class CategoriesController < ApiController
      respond_to :json

      def index
        @categories = Category.order(:title)
      end

      def show
        category = Category.friendly.find(params[:id])
        @stations = category.stations.active
      end
    end
  end
end
