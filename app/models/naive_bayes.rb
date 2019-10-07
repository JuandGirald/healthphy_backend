class NaiveBayes
  require 'csv'

  attr_reader :data_set, :training_data

  DATA_SET_FILE = 'back.csv'

  # entry: array of hashes with questions answer
  #{"1"=>"a", "2"=>"b", "3"=>"c", "4"=>"a"}
  #
  #classes: class names to classify
  def initialize(entries:, body_part:)
    @entries = entries
    @body_part = body_part
    @data_set = get_data_set
    @training_data = []
    @classes = data_set.headers[2, data_set.headers.length]
  end

  def training
    @entries.each do |key, value|
      training_data << data_set.select do |data| 
        data['question'].to_s == key.to_s && data['option'] == value
      end[0]
    end
  end

  def classify
    res = @classes.sort_by do |class_name|
      class_probability(class_name)
    end

    res[-1]
  end

  private
    def get_data_set
      CSV.read(
        Rails.root.join('app', 'models', DATA_SET_FILE),
        col_sep: ';', 
        converters: :numeric, headers:true 
      )
    end

    #given a class, this method determines the probability
    #of a certain value ocurring for a given feature
    def class_probability(class_name)
      (naive_numerator(class_name) * 0.25) / naive_denominator 
    end

    # multiply all asnwers probabilities for a given class
    def naive_numerator(class_name) 
      training_data.map{ |data| data[class_name] }.reduce(:*)
    end

    # multiply the probabilities of each class
    def naive_denominator
      (1.0 / @classes.length )**@classes.length
    end
end