class CreateUserPlan
  BACK_PLANS_IDS     = ['5', '6', '7', '16']
  KNEE_PLANS_IDS     = ['1', '2', '3', '4']
  ANKLE_PLANS_IDS    = ['9', '8', '11', '10']
  SHOULDER_PLANS_IDS = ['12', '13', '14', '15']

  attr_reader :answers

  def initialize(answers)
    @answers = format_answers(answers)
    @data_entries = get_data_entries
    @body_part = answers['10']['value']
  end

  def call
    process = NaiveBayes.new(
      entries: @data_entries,
      body_part: @body_part
    )

    # train the data set
    process.training

    # classify the data
    personalized_plan = process.classify

    # commented for now while adding more plans
    # return { personalized_plan: personalized_plan } if personalized_plan == 'no'

    perzonalized_plans_data
  end

  private
    # format questionary asnwers to get just value answers without key label
    def format_answers(answers)
      answers.select { |k, v| v.delete("label") }
    end

    # get data entries from answers for naive_bayes algoritm 
    #{"1"=>"a", "2"=>"b", "3"=>"c", "4"=>"a"}
    def get_data_entries
      answers
        .slice('0', '3', '5', '6')
        .map.with_index { |(k, v), i| { 
          (i + 1).to_s  => v["value"] } 
        }.inject(:merge)
    end

    # set to 1 plan for beta testing
    def perzonalized_plans_data
      ids = eval("#{@body_part.upcase}_PLANS_IDS")

      HealthphyApi.plans_by_ids(ids)
    end
end