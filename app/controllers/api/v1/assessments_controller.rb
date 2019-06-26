module Api
  module V1
    class AssessmentController < APIcontroller
      def create
        @user_plan = CreateUserPlan.call(params[:asnwers])

        render json: @user_plan
      end
    end
  end
end
