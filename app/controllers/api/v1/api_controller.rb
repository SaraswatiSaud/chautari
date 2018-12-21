# frozen_string_literal: true

module Api
  module V1
    # Api Controller parent class
    class ApiController < ApplicationController
      def json_response(object, status = :ok)
        render json: object, status: status
      end
    end
  end
end
