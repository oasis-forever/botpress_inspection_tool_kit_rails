class TrainingData
  include ActiveModel::Model

  attr_accessor :training_data

  validates :training_data, presence: true

  def save
    valid? ? true : false
  end
end
