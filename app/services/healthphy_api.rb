module HealthphyApi
  include HTTParty
  base_uri 'warm-citadel-63939.herokuapp.com/'
  
  class << self
    def plans_by_ids(ids)
      get_plans.select { |w| ids.include? w['workout_id'] }
    end

    def get_plans
      self.get("/json/data_workouts.php").parsed_response
    end
  end
end
