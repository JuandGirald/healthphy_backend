module Api
  module V1
    class AssessmentsController < ApplicationController
      def create
      	answers = assessments_params.to_h
        
        @user_plan = CreateUserPlan.new(answers).call

        render json: @user_plan
      end

      private
      	def assessments_params
      		params[:answers].permit!
      	end
    end
  end
end
