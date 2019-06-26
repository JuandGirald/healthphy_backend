module Api
  module V1
    class APIController < ApplicationController
      # include Api::ErrorHandler

      respond_to :json
    end
  end
end

